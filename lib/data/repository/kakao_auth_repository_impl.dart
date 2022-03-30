import 'package:social_login/data/remote/auth/kakao_auth_api.dart';
import 'package:social_login/data/remote/auth/kakao_user_api.dart';
import 'package:social_login/domain/model/token_response.dart';
import 'package:social_login/domain/model/user_response.dart';
import 'package:social_login/domain/repository/oauth_api_repository.dart';

class KakaoAuthRepositoryImpl implements OAuthApiRepository {
  final KakaoAuthApi _kakaoAuthApi;
  final KakaoUserApi _kakaoUserAPi;

  KakaoAuthRepositoryImpl(
    this._kakaoAuthApi,
    this._kakaoUserAPi,
  );

  @override
  Future<TokenResponse> login() async {
    final authCode = await _kakaoAuthApi.requestAuthorizationCode();

    final token = await _kakaoAuthApi.requestToken(authCode);

    return token;
  }

  @override
  Future<UserResponse> getUserData() async {
    return await _kakaoUserAPi.getUserData();
  }

  @override
  Future<void> logout() async {
    await _kakaoUserAPi.signOut();
  }
}
