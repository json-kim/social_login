import 'package:flutter/material.dart';

import 'package:social_login/domain/usecase/auth/logout_use_case.dart';
import 'package:social_login/domain/usecase/auth/social_login_use_case.dart';
import 'package:social_login/presentation/auth/auth_event.dart';

class AuthViewModel with ChangeNotifier {
  final SocialLoginUseCase _socialLoginUseCase;
  final LogoutUseCase _logoutUseCase;

  AuthViewModel(this._socialLoginUseCase, this._logoutUseCase);

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
    final result = await _socialLoginUseCase(LoginMethod.google);

    result.when(
      success: (_) {},
      error: (error) {
        // 에러시 ui 이벤트 발생
      },
    );
  }

  Future<void> _loginWithApple() async {}
  Future<void> _loginWithKakao() async {}
  Future<void> _loginWithNaver() async {}
  Future<void> _loginWithFacebook() async {}
  Future<void> _loginWithTwitter() async {}
  Future<void> _loginWithYahoo() async {}
  Future<void> _logout() async {}
}
