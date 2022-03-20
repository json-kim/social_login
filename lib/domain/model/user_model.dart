import 'package:social_login/core/util/social_data.dart';

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
