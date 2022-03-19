import 'package:logger/logger.dart';
import 'package:social_login/core/error/auth_exception.dart';
import 'package:social_login/core/result/result.dart';

class ErrorApi {
  static Future<Result<T>> handleAuthError<T>(
      Future<Result<T>> Function() requestFunction, Logger logger) async {
    try {
      return await requestFunction();
    } on Exception catch (e) {
      logger.e('${e.runtimeType}: 에러 발생', e);
      return Result.error(e);
    } catch (e) {
      logger.e('${e.runtimeType}: 에러 발생');
      return Result.error(BaseException('Auth 에러 발생'));
    }
  }
}
