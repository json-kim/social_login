import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_login/core/error/auth_exception.dart';

class GoogleAuthApi {
  final GoogleSignIn _googleSignIn;
  final List<String>? scopes;

  GoogleAuthApi({
    this.scopes,
    GoogleSignIn? googleSignIn,
  }) : _googleSignIn = googleSignIn ?? GoogleSignIn(scopes: scopes ?? []);

  /// 구글 로그인 (유저 정보 리턴)
  Future<GoogleSignInAccount> requestSignInAccount() async {
    final googleAccount = await _googleSignIn.signIn();

    if (googleAccount == null) {
      throw BaseException('로그인 캔슬');
    }

    return googleAccount;
  }

  /// 토큰 발급
  Future<GoogleSignInAuthentication> requestToken(
      GoogleSignInAccount googleSignInAccount) async {
    return await googleSignInAccount.authentication;
  }

  /// oauth 인증서 발급
  Future<AuthCredential> requestAuthCredential(
      GoogleSignInAuthentication authentication) async {
    return GoogleAuthProvider.credential(
      idToken: authentication.idToken,
      accessToken: authentication.accessToken,
    );
  }

  /// 로그아웃 메서드
  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }
}
