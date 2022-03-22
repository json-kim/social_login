import 'package:social_login/domain/model/user_model.dart';
import 'package:firebase_auth_platform_interface/src/auth_credential.dart';
import 'package:social_login/domain/repository/oauth_repository.dart';
import 'package:social_login/domain/usecase/auth/social_login_use_case.dart';

class SdkOAuthRepository implements OAuthRepository {
  @override
  Future<AuthCredential> getCredential() {
    // TODO: implement getCredential
    throw UnimplementedError();
  }

  @override
  Future<String> getCustomToken() {
    // TODO: implement getCustomToken
    throw UnimplementedError();
  }

  @override
  Future<UserModel> getUserData() {
    // TODO: implement getUserData
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  void setOAuthApi(LoginMethod loginMethod) {
    // TODO: implement setOAuthApi
  }
}
