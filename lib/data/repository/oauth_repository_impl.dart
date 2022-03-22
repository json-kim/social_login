import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_login/core/result/result.dart';
import 'package:social_login/data/remote/auth/auth_api.dart';
import 'package:social_login/domain/model/user_model.dart';
import 'package:social_login/domain/repository/oauth_repository.dart';
import 'package:social_login/domain/usecase/auth/social_login_use_case.dart';

class OAuthRepositoryImpl implements OAuthRepository {
  final Map<LoginMethod, AuthApi> _authApiSet;
  AuthApi? _currentApi;

  OAuthRepositoryImpl(this._authApiSet);

  @override
  void setOAuthApi(LoginMethod loginMethod) {
    _currentApi = _authApiSet[loginMethod]!;
  }

  @override
  Future<void> logout() async {
    throw UnimplementedError();
    final result = await _currentApi!.signOut();
  }

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
}
