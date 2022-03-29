import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_login/service/kakao/kakao_exception.dart';

class KakaoExceptionHandler {
  static Future<T> handleApiError<T>(
      Future<T> Function() requestFunction) async {
    try {
      return await requestFunction();
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        await FirebaseAuth.instance.signOut();
        throw KakaoTokenException(message: '토큰 만료');
      } else {
        throw e.error;
      }
    } catch (e) {
      rethrow;
    }
  }
}
