import 'package:social_login/data/remote/auth/kakao_auth_api.dart';
import 'package:social_login/data/remote/auth/kakao_user_api.dart';
import 'package:social_login/data/remote/firebase/firebase_auth_remote_data_source.dart';
import 'package:social_login/domain/model/token_response.dart';
import 'package:social_login/domain/model/user_response.dart';

class KakaoAuthRepositoryImpl {
  final KakaoAuthApi _kakaoAuthApi;
  final KakaoUserApi _kakaoUserAPi;
  final FirebaseAuthRemoteDataSource _firebaseAuthRemoteDataSource;

  KakaoAuthRepositoryImpl(this._kakaoAuthApi, this._kakaoUserAPi,
      this._firebaseAuthRemoteDataSource);

  Future<TokenResponse> login() async {
    final authCode = await _kakaoAuthApi.requestAuthorizationCode();

    final token = await _kakaoAuthApi.requestToken(authCode);

    return token;
  }

  Future<UserResponse> getUserData(String accessToken) async {
    return await _kakaoUserAPi.getUserData(accessToken);
  }

  Future<void> logout(String accessToken) async {
    await _kakaoUserAPi.signOut(accessToken);
  }

  Future<String> createCustomToken(UserResponse userResponse) async {
    return await _firebaseAuthRemoteDataSource.requestCustomToken(userResponse);
  }
}
