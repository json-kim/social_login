import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthApi {
  Future<UserCredential> signIn();
  Future<void> signOut();
}
