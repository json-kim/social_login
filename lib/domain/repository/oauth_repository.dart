import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_login/core/result/result.dart';
import 'package:social_login/domain/model/user_model.dart';
import 'package:social_login/domain/usecase/auth/social_login_use_case.dart';

abstract class OAuthRepository {
  Future<UserModel> getUserData();

  Future<UserCredential> signIn();

  Future<void> signOut();

  void setOAuthApi(LoginMethod loginMethod);
}
