import 'package:social_login/core/result/result.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AppleAuthApi {
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
