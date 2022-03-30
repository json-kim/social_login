import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_login/domain/repository/oauth_sdk_repository.dart';

class GoogleLoginUseCase {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final OAuthSdkRepository _googleAuthRepository;

  GoogleLoginUseCase(this._googleAuthRepository);

  Future<void> call() async {
    // oauth 인증서 발급받기
    final authCredential = await _googleAuthRepository.login();

    // 파이어베이스 인증
    final userCredential = await _auth.signInWithCredential(authCredential);
  }
}
