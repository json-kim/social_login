import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';

import 'package:social_login/data/repository/kakao_auth_repository_impl.dart';
import 'package:social_login/domain/repository/token_repository.dart';
import 'package:social_login/domain/repository/user_repository.dart';
import 'package:social_login/domain/usecase/auth/social_login_use_case.dart';

class KakaoLoginUseCase {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final KakaoAuthRepositoryImpl _kakaoAuthRepository;
  final TokenRepository _tokenRepository;
  final UserRepository _userRepository;

  KakaoLoginUseCase(
      this._kakaoAuthRepository, this._tokenRepository, this._userRepository);

  Future<void> call() async {
    // 카카오 소셜 로그인(토큰 발급)
    final token = await _kakaoAuthRepository.login();

    // 토큰 로컬에 저장
    await _tokenRepository.saveAccessToken(
        LoginMethod.kakao, token.accessToken);
    if (token.refreshToken != null) {
      await _tokenRepository.saveRefreshToken(
          LoginMethod.kakao, token.refreshToken!);
    }

    // 유저정보 가져오기
    final user = await _kakaoAuthRepository.getUserData(token.accessToken);

    // 유저정보 로컬에 저장
    await _userRepository.saveUser(user);

    // 커스텀토큰 발급
    final customToken = await _kakaoAuthRepository.createCustomToken(user);

    // 파이어베이스 인증
    await _auth.signInWithCustomToken(customToken);
  }
}
