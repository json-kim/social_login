import 'package:dio/dio.dart';
import 'package:social_login/core/error/auth_exception.dart';
import 'package:social_login/domain/model/user_response.dart';
import 'package:social_login/domain/usecase/auth/constants.dart';
import 'package:social_login/service/firebase_functions/functions_api_factory.dart';
import 'package:social_login/service/firebase_functions/functions_constants.dart';

class FirebaseAuthRemoteDataSource {
  final Dio _apiDio;

  FirebaseAuthRemoteDataSource({Dio? apiDio})
      : _apiDio = apiDio ?? FunctionsApiFactory.apiDio;

  Future<String> requestCustomToken(UserResponse userResponse) async {
    if (userResponse.loginMethod == LoginMethod.kakao) {
      return _requestCustomTokenKakao(userResponse);
    } else if (userResponse.loginMethod == LoginMethod.naver) {
      return _requestCustomTokenNaver(userResponse);
    } else {
      return Future.error(BaseException(
          '${userResponse.loginMethod} is not supporting custom token login'));
    }
  }

  Future<String> _requestCustomTokenKakao(UserResponse userResponse) async {
    final body = {
      FunctionsConstants.uid: userResponse.uid,
      FunctionsConstants.email: userResponse.email,
      FunctionsConstants.displayName: userResponse.userName,
      FunctionsConstants.photoUrl: userResponse.photoUrl,
    };

    final response = await _apiDio
        .post<String>(FunctionsConstants.kakaoTokenPath, data: body);

    final token = response.data;

    return token!;
  }

  Future<String> _requestCustomTokenNaver(UserResponse userResponse) async {
    final body = {
      FunctionsConstants.uid: userResponse.uid,
      FunctionsConstants.email: userResponse.email,
      FunctionsConstants.displayName: userResponse.userName,
      FunctionsConstants.photoUrl: userResponse.photoUrl,
    };

    final response = await _apiDio
        .post<String>(FunctionsConstants.naverTokenPath, data: body);

    final token = response.data;

    return token!;
  }
}
