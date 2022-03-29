import 'package:dio/dio.dart';
import 'package:social_login/domain/model/user_response.dart';
import 'package:social_login/domain/usecase/auth/social_login_use_case.dart';
import 'package:social_login/service/kakao/kakao_api_factory.dart';
import 'package:social_login/service/kakao/kakao_constants.dart';
import 'package:social_login/service/kakao/kakao_exception_handler.dart';

class KakaoUserApi {
  final Dio _tokenDio;

  KakaoUserApi({Dio? tokenDio})
      : _tokenDio = tokenDio ?? KakaoApiFactory.tokenApi;

  static final instance = KakaoUserApi();

  // 카카오 로그아웃 (토큰 서버에서 만료)
  Future<void> signOut(String accessToken) async {
    await KakaoExceptionHandler.handleApiError(() async {
      await _tokenDio.post(KakaoConstants.logoutPath);
    });
  }

  // 유저 정보 가져오기
  Future<UserResponse> getUserData(String token) async {
    return await KakaoExceptionHandler.handleApiError(() async {
      final response = await _tokenDio.get(KakaoConstants.userPath);

      final userMap = response.data;

      final userName =
          userMap['kakao_account']['profile']['nickname'] as String;
      final email = userMap['kakao_account']['email'] as String;
      final photoUrl =
          userMap['kakao_account']['profile']['profile_image_url'] as String;

      final userResponse = UserResponse(
        email: email,
        userName: userName,
        photoUrl: photoUrl,
        loginMethod: LoginMethod.kakao,
      );

      return userResponse;
    });
  }
}
