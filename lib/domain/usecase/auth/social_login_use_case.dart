import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_login/core/result/result.dart';
import 'package:social_login/domain/model/user_model.dart';
import 'package:social_login/domain/repository/oauth_repository.dart';

class SocialLoginUseCase {
  final OAuthRepository _repository;
  final _firebaseAuth = FirebaseAuth.instance;
  UserModel? _curretUserModel;

  SocialLoginUseCase(this._repository);

  Future<Result<void>> call(LoginMethod loginMethod) async {
    _repository.setOAuthApi(loginMethod);

    final UserCredential userCredential;

    switch (loginMethod) {
      case LoginMethod.google:
      case LoginMethod.apple:
      case LoginMethod.facebook:
      case LoginMethod.twitter:
      case LoginMethod.yahoo:
        userCredential = await _signInWithOAuthCredential();
        break;
      case LoginMethod.kakao:
      case LoginMethod.naver:
      default:
        userCredential = await _signInWithCustomToken();
        break;
    }
    _firebaseAuth.currentUser.

    return Result.success(null);
  }

  Future<UserCredential> _signInWithOAuthCredential() async {
    final oAuthCredential = await _repository.getCredential();

    return await _firebaseAuth.signInWithCredential(oAuthCredential);
  }

  Future<UserCredential> _signInWithCustomToken() async {
    throw UnimplementedError();
  }
}

enum LoginMethod { google, apple, kakao, naver, facebook, twitter, yahoo }
