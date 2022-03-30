import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_login/data/remote/auth/google_auth_api.dart';
import 'package:social_login/domain/repository/oauth_sdk_repository.dart';

class GoogleAuthRepositoryImpl implements OAuthSdkRepository {
  final GoogleAuthApi _googleAuthApi;

  GoogleAuthRepositoryImpl(this._googleAuthApi);

  @override
  Future<AuthCredential> login() async {
    final googleAccount = await _googleAuthApi.requestSignInAccount();

    final token = await _googleAuthApi.requestToken(googleAccount);

    final authCredential = await _googleAuthApi.requestAuthCredential(token);

    return authCredential;
  }

  @override
  Future<void> logout() async {
    await _googleAuthApi.signOut();
  }
}
