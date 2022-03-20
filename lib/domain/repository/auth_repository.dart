import 'package:social_login/core/result/result.dart';
import 'package:social_login/domain/model/user_model.dart';

abstract class AuthRepository {
  Future<Result<UserModel>> loginWithSocial();

  Future<Result<int>> logout();
}
