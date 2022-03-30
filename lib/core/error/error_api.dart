import 'package:firebase_auth/firebase_auth.dart';
import 'package:logger/logger.dart';
import 'package:social_login/core/error/auth_exception.dart';
import 'package:social_login/core/result/result.dart';
import 'package:social_login/service/kakao/kakao_exception.dart';
import 'package:social_login/service/naver/naver_exception.dart';

/// 유스케이스 단에서 에러 핸들링 메서드
class ErrorApi {
  static Future<Result<T>> handleAuthError<T>(
      Future<Result<T>> Function() requestFunction,
      Logger logger,
      String prefix) async {
    try {
      return await requestFunction();
    } on Exception catch (e) {
      if (e is KakaoTokenException || e is NaverTokenException) {
        // 토큰 만료시 로그아웃 처리
        await FirebaseAuth.instance.signOut();
      }
      logger.e('${e.runtimeType}: 에러 발생', e);
      return Result.error(e);
    } catch (e) {
      logger.e('$prefix : ${e.runtimeType}: 에러 발생, $e', e);
      return Result.error(BaseException('Auth 에러 발생'));
    }
  }
}
