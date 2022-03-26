import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:social_login/domain/model/token_response.dart';
import 'package:social_login/domain/model/user_response.dart';
import 'package:http/http.dart' as http;
import 'package:social_login/domain/usecase/auth/social_login_use_case.dart';

class KakaoAuthApi {
  @override
  Future<UserResponse> getUserData({String? token}) async {
    final uri = Uri.parse('https://kapi.kakao.com/v2/user/me');

    final response = await http.get(uri, headers: {
      'Authorization': 'Bearer $token',
    });

    final jsonResponse = jsonDecode(response.body);

    final userName =
        jsonResponse['kakao_account']['profile']['nickname'] as String;
    final email = jsonResponse['kakao_account']['email'] as String;
    final photoUrl =
        jsonResponse['kakao_account']['profile']['profile_image_url'] as String;

    final userResponse = UserResponse(
      email: email,
      userName: userName,
      photoUrl: photoUrl,
      loginMethod: LoginMethod.kakao,
    );

    return userResponse;
  }

  @override
  Future<UserCredential> signIn() async {
    throw UnimplementedError();
    // final authCode = await _requestAuthorizationCode();
  }

  // 인가 코드 발급
  Future<String> requestAuthorizationCode() async {
    final url = Uri.https('kauth.kakao.com', '/oauth/authorize', {
      'response_type': 'code',
      'client_id': 'c566e2fcfa4c8b7497bf3ca6919197ac',
      'redirect_uri':
          'https://us-central1-appfirebase-656ab.cloudfunctions.net/kakaologin',
    });

    final result = await FlutterWebAuth.authenticate(
        url: url.toString(), callbackUrlScheme: 'kakaologincallback');

    final code = Uri.parse(result).queryParameters['code'];
    if (code == null) {
      throw Exception('code 없음');
    }
    return code;
  }

  // 토큰 발급
  Future<TokenResponse> requestToken(String authCode) async {
    final uri = Uri.parse('https://kauth.kakao.com/oauth/token');
    final response = await http.post(uri, body: {
      'grant_type': 'authorization_code',
      'client_id': 'c566e2fcfa4c8b7497bf3ca6919197ac',
      'redirect_uri':
          'https://us-central1-appfirebase-656ab.cloudfunctions.net/kakaologin',
      'code': authCode,
    });

    final jsonResponse = jsonDecode(response.body);
    final tokenResponse = TokenResponse.fromJson(jsonResponse);

    return tokenResponse;
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }
}
