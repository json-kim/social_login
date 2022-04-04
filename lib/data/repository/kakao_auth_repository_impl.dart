import 'package:social_login/data/local/token_local_data_source.dart';
import 'package:social_login/data/remote/auth/kakao_auth_api.dart';
import 'package:social_login/data/remote/auth/kakao_user_api.dart';
import 'package:social_login/domain/model/token_response.dart';
import 'package:social_login/domain/model/user_response.dart';
import 'package:social_login/domain/repository/oauth_api_repository.dart';
import 'package:social_login/domain/usecase/auth/constants.dart';

class KakaoAuthRepositoryImpl implements OAuthApiRepository {
  final KakaoAuthApi _kakaoAuthApi;
  final KakaoUserApi _kakaoUserAPi;
  final TokenLocalDataSource _tokenLocalDataSource;

  KakaoAuthRepositoryImpl(
    this._kakaoAuthApi,
    this._kakaoUserAPi,
    this._tokenLocalDataSource,
  );

  @override
  Future<TokenResponse> login() async {
    final authCode = await _kakaoAuthApi.requestAuthorizationCode();

    final token = await _kakaoAuthApi.requestToken(authCode);
    await _setTokenData(token);

    return token;
  }

  Future<void> _setTokenData(TokenResponse token) async {
    // 토큰 로컬에 저장(id토큰, access토큰)
    await _tokenLocalDataSource.saveRefreshToken(
        LoginMethod.kakao, token.refreshToken);
    await _tokenLocalDataSource.saveAccessToken(
        LoginMethod.kakao, token.accessToken);
  }

  Future<void> _deleteTokenData() async {
    await _tokenLocalDataSource.deleteRefreshToken(LoginMethod.kakao);
    await _tokenLocalDataSource.deleteAccessToken(LoginMethod.kakao);
  }

  @override
  Future<UserResponse> getUserData() async {
    return await _kakaoUserAPi.getUserData();
  }

  @override
  Future<void> logout() async {
    await _deleteTokenData();
    await _kakaoUserAPi.signOut();
  }
}
