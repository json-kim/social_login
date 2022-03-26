import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_login/domain/model/user_response.dart';

abstract class AuthApi {
  Future<UserCredential> signIn();
  Future<void> signOut();
  UserResponse getUserData({String? token});
}
