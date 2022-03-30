// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:logger/logger.dart';
// import 'package:social_login/data/local/user_local_data_source.dart';
// import 'package:social_login/data/remote/auth/auth_api.dart';
// import 'package:social_login/data/remote/auth/google_auth_api.dart';
// import 'package:social_login/domain/model/user_response.dart';
// import 'package:social_login/domain/repository/oauth_repository.dart';
// import 'package:social_login/domain/usecase/auth/social_login_use_case.dart';

// class OAuthRepositoryImpl implements OAuthRepository {
//   final Map<LoginMethod, AuthApi> _authApiSet;
//   // 디폴트 oauth api는 구글
//   LoginMethod _currentLoginMethod = LoginMethod.google;
//   AuthApi _currentApi = GoogleAuthApi();

//   final UserLocalDataSource _userLocalDataSource;

//   OAuthRepositoryImpl(this._authApiSet, this._userLocalDataSource);

//   @override
//   void setOAuthApi(LoginMethod loginMethod) {
//     _currentLoginMethod = loginMethod;
//     _currentApi = _authApiSet[_currentLoginMethod]!;
//   }

//   /// 로컬에 저장된 유저 데이터가 있을 시, 해당 데이터 사용
//   /// 없다면 첫 로그인이므로 불러온 데이터 사용
//   @override
//   Future<UserResponse> getUserData(String uid) async {
//     final localUserResponse =
//         await _userLocalDataSource.loadUserData(_currentLoginMethod);

//     if (localUserResponse.uid != null && localUserResponse.uid == uid) {
//       return localUserResponse;
//     }

//     return _currentApi.getUserData();
//   }

//   @override
//   Future<void> signOut() async {
//     return await _currentApi.signOut();
//   }

//   @override
//   Future<UserCredential> signIn() async {
//     final userCredential = await _currentApi.signIn();
//     final userData = _currentApi.getUserData();

//     // 첫 로그인일 경우 유저 정보 로컬에 저장
//     if ((userCredential.additionalUserInfo?.isNewUser ?? false) ||
//         userData.email != null) {
//       final userResponse = _currentApi.getUserData();
//       await _userLocalDataSource.saveUserData(userResponse);
//     }
//     return userCredential;
//   }
// }
