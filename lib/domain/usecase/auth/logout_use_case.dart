import 'package:social_login/core/result/result.dart';
import 'package:social_login/domain/repository/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository _repository;

  LogoutUseCase(
    this._repository,
  );

  Future<Result<int>> call() async {
    throw UnimplementedError();
  }
}
