class KakaoException implements Exception {
  final String? message;

  KakaoException({this.message});
}

class KakaoTokenException extends KakaoException {
  KakaoTokenException({this.message}) : super(message: message);

  final String? message;
}
