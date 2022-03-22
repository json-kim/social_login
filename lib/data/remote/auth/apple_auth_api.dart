import 'package:firebase_auth/firebase_auth.dart';

import 'auth_api.dart';

class AppleAuthApi implements AuthApi {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<UserCredential> signIn() {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
