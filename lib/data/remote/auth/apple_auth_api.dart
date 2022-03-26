import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'package:social_login/core/error/auth_exception.dart';
import 'package:social_login/domain/model/user_response.dart';
import 'package:social_login/domain/usecase/auth/social_login_use_case.dart';

import 'auth_api.dart';

class AppleAuthApi implements AuthApi {
  final List<AppleIDAuthorizationScopes> scopes;
  final _firebaseAuth = FirebaseAuth.instance;
  AuthorizationCredentialAppleID? _appleCredential;
  String? uid;

  AppleAuthApi({
    scopes,
  }) : scopes = scopes ??
            [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ];

  @override
  Future<UserCredential> signIn() async {
    final oauthCredential = await _getCredential();

    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    uid = userCredential.user?.uid;

    return userCredential;
  }

  @override
  UserResponse getUserData({String? token}) {
    return UserResponse(
      uid: uid,
      email: _appleCredential?.email,
      userName: _appleCredential?.givenName,
      loginMethod: LoginMethod.apple,
    );
  }

  Future<AuthCredential> _getCredential() async {
    // 애플 인증정보를 다시 실행?시키는 어떠한 공격을 방지하기 위해 인증 요청에 32자리 문자열을 포함시킵니다.
    // 우선 애플 로그인에 암호화시킨 32자리 문자열을 포함시키고
    // 파이어베이스로 로그인할 때, 원본 문자열을 포함시키면
    // 애플 로그인의 리턴 결과로 돌아온 문자열이 원본 문자열을 sha256 암호화 시킨 값과 일치해야 합니다.
    final rawNonce = _generateNonce();
    final nonce = _sha256ofString(rawNonce);

    // 애플 계정으로 애플에 인증 요청
    _appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    if (_appleCredential == null) {
      throw BaseException('애플 로그인 실패');
    }

    // 애플로부터 리턴받은 인증 id 토큰으로 OAuth 인증정보 생성
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: _appleCredential!.identityToken,
      rawNonce: rawNonce,
    );

    return oauthCredential;
  }

  @override
  Future<void> signOut() {
    throw BaseException('Apple does not support sign up');
  }

  /// 안전한 램덤 문자열 생성 메서드
  /// 애플 로그인 한 뒤, 다시 로그아웃하고 로그인 하면 동작하지 않는 문제 해결을 위해 랜덤 문자열을 사용해서 로그인에 이용
  String _generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// sha256 해시 함수 암호화(단방향)를 통해 입력된 문자열을 암호화된 문자열로 변형
  String _sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
