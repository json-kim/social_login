import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_login/domain/model/user_model.dart';

class HomeViewModel with ChangeNotifier {
  final _firebaseAuth = FirebaseAuth.instance;

  UserModel userModel = UserModel(email: '', userName: '', photoUrl: '');

  UserModel get user => UserModel(
        email: _firebaseAuth.currentUser?.email ?? '',
        userName: _firebaseAuth.currentUser?.displayName ?? '',
        photoUrl: _firebaseAuth.currentUser?.photoURL ?? '',
      );

  void reset() {
    notifyListeners();
  }
}
