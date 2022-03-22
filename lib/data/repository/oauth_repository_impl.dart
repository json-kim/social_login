import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_login/core/error/auth_exception.dart';
import 'package:social_login/data/remote/auth/auth_api.dart';
import 'package:social_login/data/remote/auth/google_auth_api.dart';
import 'package:social_login/domain/model/user_model.dart';
import 'package:social_login/domain/repository/oauth_repository.dart';
import 'package:social_login/domain/usecase/auth/social_login_use_case.dart';

class OAuthRepositoryImpl implements OAuthRepository {
  final Map<LoginMethod, AuthApi> _authApiSet;
  AuthApi _currentApi;

  // 디폴트 oauth api는 구글
  OAuthRepositoryImpl(this._authApiSet)
      : _currentApi = _authApiSet['google'] ?? GoogleAuthApi();

  @override
  void setOAuthApi(LoginMethod loginMethod) {
    _currentApi = _authApiSet[loginMethod]!;
  }

  @override
  Future<UserModel> getUserData() {
    // TODO: implement getUserData
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<UserCredential> signIn() async {
    final result = await _currentApi.signIn();
    return result;
  }
}
