import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:social_login/core/error/auth_exception.dart';
import 'package:social_login/data/remote/auth/auth_api.dart';
import 'package:social_login/domain/model/user_response.dart';
import 'package:social_login/domain/usecase/auth/social_login_use_case.dart';

class GoogleAuthApi implements AuthApi {
  final _firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn? _googleSignIn;
  GoogleSignInAccount? _googleSignInAccount;
  List<String>? scopes;

  GoogleAuthApi({
    this.scopes,
  }) {
    _googleSignIn = GoogleSignIn(scopes: scopes ?? []);
  }

  @override
  UserResponse getUserData({String? token}) {
    return UserResponse(
      email: _googleSignInAccount?.email,
      userName: _googleSignInAccount?.displayName,
      photoUrl: _googleSignInAccount?.photoUrl,
      loginMethod: LoginMethod.google,
    );
  }

  /// 로그인 메서드
  @override
  Future<UserCredential> signIn() async {
    final credential = await _getCredential();

    return await _firebaseAuth.signInWithCredential(credential);
  }

  Future<OAuthCredential> _getCredential() async {
    // 구글계정으로 로그인(웹브라우저를 통해) => 구글계정정보(displayName, id, email, photoUrl, 인가코드)
    _googleSignInAccount = await _googleSignIn?.signIn();

    if (_googleSignInAccount == null) {
      throw BaseException('구글 로그인 실패');
    }

    // 계정 인증정보 가져오기 (id토큰, 액세스 토큰)
    final _googleSignInAuthentication =
        await _googleSignInAccount?.authentication;

    if (_googleSignInAuthentication == null) {
      throw BaseException('인증정보 가져오기 실패');
    }

    // OAuthCredential 리턴
    return GoogleAuthProvider.credential(
      idToken: _googleSignInAuthentication.idToken,
      accessToken: _googleSignInAuthentication.accessToken,
    );
  }

  /// 로그아웃 메서드
  @override
  Future<void> signOut() async {
    await _googleSignIn?.signOut();
    await _firebaseAuth.signOut();
  }
}
