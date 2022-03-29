import 'package:social_login/data/local/token_local_data_source.dart';
import 'package:social_login/domain/repository/token_repository.dart';
import 'package:social_login/domain/usecase/auth/social_login_use_case.dart';

class TokenRepositoryImpl implements TokenRepository {
  final TokenLocalDataSource _tokenLocalDataSource;

  TokenRepositoryImpl(this._tokenLocalDataSource);

  @override
  Future<void> deleteAccessToken(LoginMethod loginMethod) async {
    await _tokenLocalDataSource.deleteAccessToken(loginMethod);
  }

  @override
  Future<void> deleteRefreshToken(LoginMethod loginMethod) async {
    await _tokenLocalDataSource.deleteRefreshToken(loginMethod);
  }

  @override
  Future<String?> loadAccessToken(LoginMethod loginMethod) async {
    return await _tokenLocalDataSource.loadAccessToken(loginMethod);
  }

  @override
  Future<String?> loadRefreshToken(LoginMethod loginMethod) async {
    return await _tokenLocalDataSource.loadRefreshToken(loginMethod);
  }

  @override
  Future<void> saveAccessToken(
      LoginMethod loginMethod, String accessToken) async {
    await _tokenLocalDataSource.saveAccessToken(loginMethod, accessToken);
  }

  @override
  Future<void> saveRefreshToken(
      LoginMethod loginMethod, String refreshToken) async {
    await _tokenLocalDataSource.saveRefreshToken(loginMethod, refreshToken);
  }
}
