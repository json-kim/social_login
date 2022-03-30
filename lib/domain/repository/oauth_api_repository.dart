import 'package:social_login/domain/model/token_response.dart';
import 'package:social_login/domain/model/user_response.dart';

// REST API를 사용하는 oauth 로그인
abstract class OAuthApiRepository {
  Future<UserResponse> getUserData();
  Future<TokenResponse> login();
  Future<void> logout();
}
