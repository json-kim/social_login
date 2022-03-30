import 'package:social_login/domain/model/user_response.dart';

abstract class FAuthRepository {
  Future<String> issueCustomToken(UserResponse userResponse);
}
