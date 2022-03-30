import 'package:social_login/domain/model/user_response.dart';
import 'package:social_login/domain/usecase/auth/constants.dart';

abstract class UserRepository {
  Future<UserResponse> loadUser(LoginMethod loginMethod);
  Future<void> saveUser(UserResponse userResponse);
  Future<void> deleteUser(LoginMethod loginMethod);
}
