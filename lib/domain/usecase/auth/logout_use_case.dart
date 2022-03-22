import 'package:social_login/core/result/result.dart';
import 'package:social_login/domain/repository/oauth_repository.dart';

class LogoutUseCase {
  final OAuthRepository _repository;

  LogoutUseCase(
    this._repository,
  );

  Future<Result<int>> call() async {
    throw UnimplementedError();
  }
}
