import 'package:social_login/domain/usecase/auth/social_login_use_case.dart';

class UserResponse {
  String? uid;
  String? email;
  String? userName;
  String? photoUrl;
  LoginMethod loginMethod;

  UserResponse({
    this.uid,
    this.email,
    this.userName,
    this.photoUrl,
    required this.loginMethod,
  });

  @override
  String toString() {
    return 'UserResponse(uid: $uid, email: $email, userName: $userName, photoUrl: $photoUrl, loginMethod: $loginMethod)';
  }
}
