import 'package:social_login/domain/model/user_response.dart';
import 'package:social_login/domain/usecase/auth/social_login_use_case.dart';

abstract class UserRepository {
  Future<UserResponse> loadUser(LoginMethod loginMethod);
  Future<void> saveUser(UserResponse userResponse);
  Future<void> deleteUser(LoginMethod loginMethod);
}
