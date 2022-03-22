import 'package:social_login/domain/usecase/auth/social_login_use_case.dart';

class UserModel {
  String uid;
  String email;
  String userName;
  String photoUrl;
  LoginMethod loginMethod;

  UserModel({
    required this.uid,
    required this.email,
    required this.userName,
    required this.photoUrl,
    required this.loginMethod,
  });
}
