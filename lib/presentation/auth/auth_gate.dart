import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_login/presentation/auth/auth_screen.dart';
import 'package:social_login/presentation/home/home_screen.dart';
import 'package:social_login/presentation/home/home_view_model.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return AuthScreen();
          }
          return ChangeNotifierProvider(
              create: (context) => HomeViewModel(), child: HomeScreen());
        });
  }
}
