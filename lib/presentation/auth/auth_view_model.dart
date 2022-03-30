import 'package:flutter/material.dart';
import 'package:social_login/domain/usecase/auth/apple_login_use_case.dart';
import 'package:social_login/domain/usecase/auth/google_login_use_case.dart';
import 'package:social_login/domain/usecase/auth/kakao_login_use_case.dart';

import 'package:social_login/domain/usecase/auth/logout_use_case.dart';
import 'package:social_login/domain/usecase/auth/naver_login_use_case.dart';
import 'package:social_login/presentation/auth/auth_event.dart';

class AuthViewModel with ChangeNotifier {
  final GoogleLoginUseCase _googleLoginUseCase;
  final AppleLoginUseCase _appleLoginUseCase;
  final KakaoLoginUseCase _kakaoLoginUseCase;
  final NaverLoginUseCase _naverLoginUseCase;
  final LogoutUseCase _logoutUseCase;

  AuthViewModel(
    this._googleLoginUseCase,
    this._appleLoginUseCase,
    this._kakaoLoginUseCase,
    this._naverLoginUseCase,
    this._logoutUseCase,
  );

  void onEvent(AuthEvent event) {
    event.when(
      loginWithGoogle: _loginWithGoogle,
      loginWithApple: _loginWithApple,
      loginWithKakao: _loginWithKakao,
      loginWithNaver: _loginWithNaver,
      loginWithFacebook: _loginWithFacebook,
      loginWithTwitter: _loginWithTwitter,
      loginWithYahoo: _loginWithYahoo,
      logout: _logout,
    );
  }

  Future<void> _loginWithGoogle() async {
    await _googleLoginUseCase();
  }

  Future<void> _loginWithApple() async {
    await _appleLoginUseCase();
  }

  Future<void> _loginWithKakao() async {
    await _kakaoLoginUseCase();
  }

  Future<void> _loginWithNaver() async {
    await _naverLoginUseCase();
  }

  Future<void> _loginWithFacebook() async {}
  Future<void> _loginWithTwitter() async {}
  Future<void> _loginWithYahoo() async {}

  Future<void> _logout() async {
    final result = await _logoutUseCase();

    result.when(
        success: (_) {},
        error: (error) {
          print('TODO: 로그 아웃 에러');
        });
  }
}
