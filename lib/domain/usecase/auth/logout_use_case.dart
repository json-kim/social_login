import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_login/core/result/result.dart';
import 'package:social_login/domain/repository/oauth_repository.dart';

class LogoutUseCase {
  final OAuthRepository _repository;
  final _firebaseAuth = FirebaseAuth.instance;

  LogoutUseCase(
    this._repository,
  );

  Future<Result<void>> call() async {
    return Result.success(await _firebaseAuth.signOut());
  }
}
