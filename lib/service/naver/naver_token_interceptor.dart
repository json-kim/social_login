import 'package:dio/dio.dart';
import 'package:logger/logger.dart';
import 'package:social_login/data/local/token_local_data_source.dart';
import 'package:social_login/data/remote/auth/naver_auth_api.dart';
import 'package:social_login/domain/usecase/auth/social_login_use_case.dart';
import 'package:social_login/service/naver/naver_constants.dart';

class NaverTokenInterceptor extends Interceptor {
  final Dio _dio;
  final TokenLocalDataSource _tokenManager;
  final NaverAuthApi _naverAuthApi;

  NaverTokenInterceptor(this._dio, this._tokenManager, this._naverAuthApi);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // 로컬에서 네이버 토큰 가져오기
    final accessToken = await _tokenManager.loadAccessToken(LoginMethod.naver);

    // 헤더에 토큰 추가
    options.headers = {
      NaverConstants.authorization: '${NaverConstants.bearer} $accessToken',
    };
    handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    final options = err.response?.requestOptions;
    final request = err.requestOptions;
    final token = await _tokenManager.loadAccessToken(LoginMethod.naver);

    // 토큰 유효 문제가 아닌 경우(토큰 갱신으로 문제가 해결되지 않을 때)
    if (options == null || token == null || err.response?.statusCode != 401) {
      handler.next(err);
      return;
    }

    try {
      // 중간에 토큰이 갱신되었을지도 모르니, 요청시의 토큰과 현재의 토큰이 다르다면 재요청 시도
      if (request.headers[NaverConstants.authorization] !=
          '${NaverConstants.bearer} $token') {
        final response = await _dio.fetch(options);
        handler.resolve(response);
        return;
      }

      // 액세스 토큰으로 요청했을 때, 에러가 발생하면
      // 리프레시 토큰으로 토큰 갱신을 시도한다.
      // lock 해주면 현재 dio인스턴스에 요청이 들어오면 큐에 대기시켜놓는다.
      _dio.lock();

      // 리프레시 토큰으로 액세스 토큰 갱신하고
      final refreshToken =
          await _tokenManager.loadRefreshToken(LoginMethod.naver);
      final newToken = await _naverAuthApi.refreshAccessToken(refreshToken!);
      // 로컬에 저장하고
      _tokenManager.saveAccessToken(LoginMethod.naver, newToken.accessToken);
      _tokenManager.saveRefreshToken(LoginMethod.naver, newToken.refreshToken);

      // 재요청하기
      options.headers[NaverConstants.authorization] =
          '${NaverConstants.bearer} $token';

      _dio.unlock();

      final response = await _dio.fetch(options);
      handler.resolve(response);
    } catch (e) {
      // 만약 리프레시 토큰으로도 요청이 실패한다면(예를 들어 만료되어서)
      // 토큰 매니저 지워주기
      await _tokenManager.deleteAccessToken(LoginMethod.naver);
      await _tokenManager.deleteRefreshToken(LoginMethod.naver);

      handler.reject(err);
    } finally {
      _dio.unlock();
    }
  }
}
