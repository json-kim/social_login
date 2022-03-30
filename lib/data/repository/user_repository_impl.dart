import 'package:social_login/data/local/user_local_data_source.dart';
import 'package:social_login/domain/model/user_response.dart';
import 'package:social_login/domain/repository/user_repository.dart';
import 'package:social_login/domain/usecase/auth/constants.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource _userLocalDataSource;

  UserRepositoryImpl(this._userLocalDataSource);

  @override
  Future<void> deleteUser(LoginMethod loginMethod) async {
    await _userLocalDataSource.deleteUserData(loginMethod);
  }

  @override
  Future<UserResponse> loadUser(LoginMethod loginMethod) async {
    return await _userLocalDataSource.loadUserData(loginMethod);
  }

  @override
  Future<void> saveUser(UserResponse userResponse) async {
    await _userLocalDataSource.saveUserData(userResponse);
  }
}
