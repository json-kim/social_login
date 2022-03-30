import 'package:social_login/data/remote/auth/naver_auth_api.dart';

import 'package:social_login/data/remote/auth/naver_user_api.dart';
import 'package:social_login/domain/model/token_response.dart';
import 'package:social_login/domain/model/user_response.dart';
import 'package:social_login/domain/repository/oauth_api_repository.dart';

class NaverAuthRepositoryImpl implements OAuthApiRepository {
  final NaverAuthApi _naverAuthApi;
  final NaverUserApi _naverUserApi;

  NaverAuthRepositoryImpl(
    this._naverAuthApi,
    this._naverUserApi,
  );

  @override
  Future<UserResponse> getUserData() async {
    final user = await _naverUserApi.getUserData();

    return user;
  }

  @override
  Future<TokenResponse> login() async {
    // 인가코드 발급
    final authResult = await _naverAuthApi.requestAuthorizationCode();

    // 액세스 토큰 발급
    final token =
        await _naverAuthApi.requestToken(authResult.authCode, authResult.state);

    return token;
  }

  @override
  Future<void> logout() async {
    await _naverUserApi.signOut();
  }
}
