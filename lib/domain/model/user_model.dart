import 'package:social_login/domain/usecase/auth/social_login_use_case.dart';

class UserModel {
  String email;
  String userName;
  String photoUrl;

  UserModel({
    required this.email,
    required this.userName,
    required this.photoUrl,
  });
}
