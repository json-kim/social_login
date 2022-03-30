import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_login/data/remote/auth/apple_auth_api.dart';
import 'package:social_login/domain/repository/oauth_sdk_repository.dart';

class AppleAuthRepositoryImpl implements OAuthSdkRepository {
  final AppleAuthApi _appleAuthApi;

  AppleAuthRepositoryImpl(this._appleAuthApi);

  @override
  Future<AuthCredential> login() async {
    final authResult = await _appleAuthApi.requestSignInAccount();

    final authCredential =
        await _appleAuthApi.requestAuthCredential(authResult);

    return authCredential;
  }

  @override
  Future<void> logout() async {
    await _appleAuthApi.signOut();
  }
}
