import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'package:social_login/domain/model/user_response.dart';
import 'package:social_login/domain/usecase/auth/social_login_use_case.dart';

/// flutter_secure_storage 사용해서 유저정보 로컬에 저장
class UserLocalDataSource {
  final FlutterSecureStorage secureStorage;

  UserLocalDataSource(this.secureStorage);

  /// 유저정보 저장
  /// key : 소셜로그인방법 + 저장할 유저정보
  /// ex) 애플 : 'apple.uid', 'apple.aaa@aaa.com', 'apple.jsonkim', 'apple.abc.png'
  Future<void> saveUserData(UserResponse userResponse) async {
    final social = userResponse.loginMethod.name;

    await secureStorage.write(key: social + '.uid', value: userResponse.uid);
    await secureStorage.write(
        key: social + '.email', value: userResponse.email);
    await secureStorage.write(
        key: social + '.userName', value: userResponse.userName);
    await secureStorage.write(
        key: social + '.photoUrl', value: userResponse.photoUrl);
  }

  /// 유저정보 불러오기
  Future<UserResponse> loadUserData(LoginMethod loginMethod) async {
    final social = loginMethod.name;

    final uid = await secureStorage.read(key: social + '.uid');
    final email = await secureStorage.read(key: social + '.email');
    final userName = await secureStorage.read(key: social + '.userName');
    final photoUrl = await secureStorage.read(key: social + '.photoUrl');

    return UserResponse(
      uid: uid,
      email: email,
      userName: userName,
      photoUrl: photoUrl,
      loginMethod: loginMethod,
    );
  }

  /// 유저정보 삭제
  Future<void> deleteUserData(LoginMethod loginMethod) async {
    final social = loginMethod.name;

    await secureStorage.delete(key: social + '.uid');
    await secureStorage.delete(key: social + '.email');
    await secureStorage.delete(key: social + '.userName');
    await secureStorage.delete(key: social + '.photoUrl');
  }
}
