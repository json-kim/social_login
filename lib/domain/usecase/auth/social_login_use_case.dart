import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:social_login/core/error/error_api.dart';
import 'package:social_login/core/result/result.dart';
import 'package:social_login/domain/model/user_response.dart';
import 'package:social_login/domain/repository/oauth_repository.dart';

class SocialLoginUseCase {
  final OAuthRepository _repository;
  final _logger = Logger();

  SocialLoginUseCase(this._repository);

  Future<Result<void>> call(LoginMethod loginMethod) async {
    return ErrorApi.handleAuthError(() async {
      // 레포지토리에 로그인 방식 세팅
      _repository.setOAuthApi(loginMethod);

      // 로그인하여 유저 인증서 가져오기
      final userCredential = await _repository.signIn();

      // 로그인 성공 후 유저 정보 가져오기(displayName, email, photoUrl)
      final userData =
          await _repository.getUserData(userCredential.user?.uid ?? '');

      // 유저 인증서의 정보 수정
      userCredential.user?.updateDisplayName(userData.userName);
      userCredential.user?.updatePhotoURL(userData.photoUrl);

      return const Result.success(null);
    }, _logger, '$runtimeType LoginMethod(${loginMethod.name})');
  }
}

enum LoginMethod { google, apple, kakao, naver, facebook, twitter, yahoo }
