import 'package:social_login/core/result/result.dart';
import 'package:social_login/domain/model/user_model.dart';
import 'package:social_login/domain/repository/auth_repository.dart';

class SocialLoginUseCase {
  final AuthRepository _repository;

  SocialLoginUseCase(this._repository);

  Future<Result<UserModel>> call() async {
    throw UnimplementedError();
  }
}
