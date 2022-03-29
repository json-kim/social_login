import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:social_login/data/remote/firebase/firebase_auth_remote_data_source.dart';
import 'package:social_login/domain/model/user_response.dart';
import 'package:social_login/domain/usecase/auth/social_login_use_case.dart';

void main() {
  test('커스텀 토큰 발급', () async {
    final FirebaseAuthRemoteDataSource _dataSource =
        FirebaseAuthRemoteDataSource();

    final user = UserResponse(
        email: 'tkdqjaos999@gmail.com',
        userName: '재승',
        photoUrl:
            'https://lh3.googleusercontent.com/a/AATXAJx91b-OSSnUmpNLj6jKpzahMXs1kWjdvwUrQ177=s96-c',
        loginMethod: LoginMethod.kakao);
    final token = await _dataSource.requestCustomToken(user);

    Logger().i(token);
  });
}
