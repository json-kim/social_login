import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_login/domain/repository/oauth_sdk_repository.dart';

class AppleLoginUseCase {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final OAuthSdkRepository _appleAuthRepository;

  AppleLoginUseCase(this._appleAuthRepository);

  Future<void> call() async {
    // oauth 인증서 발급
    final authCredential = await _appleAuthRepository.login();

    // 파이어베이스 인증
    final userCredential = await _auth.signInWithCredential(authCredential);
  }
}
