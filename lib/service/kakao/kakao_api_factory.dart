import 'package:dio/dio.dart';
import 'package:social_login/data/local/token_local_data_source.dart';
import 'package:social_login/data/remote/auth/kakao_auth_api.dart';
import 'package:social_login/service/kakao/kakao_constants.dart';
import 'package:social_login/service/kakao/kakao_token_interceptor.dart';

class KakaoApiFactory {
  static final authApi = _authApiInstance();
  static final tokenApi = _tokenApiInstatnce();

  static Dio _authApiInstance() {
    var dio = Dio();
    dio.options.baseUrl = '${KakaoConstants.scheme}://${KakaoConstants.kauth}';
    dio.options.contentType = KakaoConstants.contentType;
    dio.interceptors.addAll([
      LogInterceptor(), // 로그 인터셉터
    ]);
    return dio;
  }

  static Dio _tokenApiInstatnce() {
    var dio = Dio();
    dio.options.baseUrl = '${KakaoConstants.scheme}://${KakaoConstants.kapi}';
    dio.options.contentType = KakaoConstants.contentType;
    dio.interceptors.addAll([
      TokenInterceptor(
          dio, TokenLocalDataSource.instance, KakaoAuthApi.instance), // 토큰 인터셉터
      LogInterceptor(), // 로그 인터셉터
    ]);
    return dio;
  }
}
