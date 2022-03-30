import 'package:social_login/domain/usecase/auth/constants.dart';

abstract class TokenRepository {
  Future<String?> loadAccessToken(LoginMethod loginMethod);
  Future<String?> loadRefreshToken(LoginMethod loginMethod);
  Future<void> deleteAccessToken(LoginMethod loginMethod);
  Future<void> deleteRefreshToken(LoginMethod loginMethod);
  Future<void> saveAccessToken(LoginMethod loginMethod, String accessToken);
  Future<void> saveRefreshToken(LoginMethod loginMethod, String refreshToken);
}
