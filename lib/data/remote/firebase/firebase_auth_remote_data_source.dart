import 'dart:convert';

import 'package:social_login/core/error/auth_exception.dart';
import 'package:social_login/domain/model/user_response.dart';
import 'package:http/http.dart' as http;
import 'package:social_login/domain/usecase/auth/social_login_use_case.dart';

class FirebaseAuthRemoteDataSource {
  final String _kakaoTokenUrl =
      'https://us-central1-appfirebase-656ab.cloudfunctions.net/createCustomTokenKakao';

  final http.Client _client;

  FirebaseAuthRemoteDataSource({
    http.Client? client,
  }) : _client = client ?? http.Client();

  Future<String> requestCustomToken(UserResponse userResponse) async {
    if (userResponse.loginMethod == LoginMethod.kakao) {
      return _requestCustomTokenKakao(_kakaoTokenUrl, userResponse);
    } else if (userResponse.loginMethod == LoginMethod.naver) {
      return _requestCustomTokenNaver('naver token url', userResponse);
    } else {
      return Future.error(BaseException(
          '${userResponse.loginMethod} is not supporting custom token login'));
    }
  }

  Future<String> _requestCustomTokenKakao(
      String customTokenUrl, UserResponse userResponse) async {
    final uri = Uri.parse(customTokenUrl);
    final response = await _client.post(uri, body: {
      'email': userResponse.email,
      'displayName': userResponse.userName,
      'photoURL': userResponse.photoUrl,
    });

    final token = response.body;

    return token;
  }

  Future<String> _requestCustomTokenNaver(
      String customTokenUrl, UserResponse userResponse) async {
    throw UnimplementedError();
  }
}
