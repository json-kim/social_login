import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:social_login/core/error/error_api.dart';
import 'package:social_login/core/result/result.dart';
import 'package:social_login/data/repository/kakao_auth_repository_impl.dart';
import 'package:social_login/domain/repository/token_repository.dart';
import 'package:social_login/domain/usecase/auth/social_login_use_case.dart';

class LogoutUseCase {
  final TokenRepository _tokenRepository;
  final KakaoAuthRepositoryImpl _kakaoAuthRepository;
  final Logger _logger = Logger();
  final _firebaseAuth = FirebaseAuth.instance;

  LogoutUseCase(
    this._tokenRepository,
    this._kakaoAuthRepository,
  );

  Future<Result<void>> call() async {
    return ErrorApi.handleAuthError(() async {
      // 토큰 만료 처리는 인터셉터 사용
      // 로그아웃
      // 로그인 방법별로 분기 나눠서 로그인 처리
      await _kakaoAuthRepository.logout();

      await _firebaseAuth.signOut();
      return const Result.success(null);
    }, _logger, '$runtimeType');
  }
}
