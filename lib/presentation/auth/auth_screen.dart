import 'package:flutter/material.dart';
import 'package:social_login/presentation/auth/auth_event.dart';
import 'package:social_login/presentation/auth/auth_view_model.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<AuthViewModel>();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 로고 이미지
            ElevatedButton(
                onPressed: () {
                  viewModel.onEvent(const AuthEvent.loginWithGoogle());
                },
                child: const Text('구글 로그인')),
            ElevatedButton(
                onPressed: () {
                  viewModel.onEvent(const AuthEvent.loginWithApple());
                },
                child: const Text('애플 로그인')),
            ElevatedButton(
                onPressed: () {
                  viewModel.onEvent(const AuthEvent.loginWithKakao());
                },
                child: const Text('카카오 로그인')),
            ElevatedButton(
                onPressed: () {
                  viewModel.onEvent(const AuthEvent.loginWithNaver());
                },
                child: const Text('네이버 로그인')),
            ElevatedButton(
                onPressed: () {
                  viewModel.onEvent(const AuthEvent.loginWithFacebook());
                },
                child: const Text('페이스북 로그인')),
            ElevatedButton(
                onPressed: () {
                  viewModel.onEvent(const AuthEvent.loginWithTwitter());
                },
                child: const Text('트위터 로그인')),
            ElevatedButton(
                onPressed: () {
                  viewModel.onEvent(const AuthEvent.loginWithYahoo());
                },
                child: const Text('야후 로그인')),
          ],
        ),
      ),
    );
  }
}
