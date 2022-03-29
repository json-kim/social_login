import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:social_login/data/local/token_local_data_source.dart';
import 'package:social_login/data/local/user_local_data_source.dart';
import 'package:social_login/data/remote/auth/apple_auth_api.dart';
import 'package:social_login/data/remote/auth/auth_api.dart';
import 'package:social_login/data/remote/auth/google_auth_api.dart';
import 'package:social_login/data/remote/auth/kakao_auth_api.dart';
import 'package:social_login/data/remote/auth/kakao_user_api.dart';
import 'package:social_login/data/remote/firebase/firebase_auth_remote_data_source.dart';
import 'package:social_login/data/repository/kakao_auth_repository_impl.dart';
import 'package:social_login/data/repository/oauth_repository_impl.dart';
import 'package:social_login/data/repository/token_repository_impl.dart';
import 'package:social_login/data/repository/user_repository_impl.dart';
import 'package:social_login/domain/repository/token_repository.dart';
import 'package:social_login/domain/repository/user_repository.dart';
import 'package:social_login/domain/usecase/auth/kakao_login_use_case.dart';
import 'package:social_login/domain/usecase/auth/logout_use_case.dart';
import 'package:social_login/domain/usecase/auth/social_login_use_case.dart';
import 'package:social_login/presentation/auth/auth_view_model.dart';
import 'package:social_login/service/kakao/kakao_api_factory.dart';

Future<List<SingleChildWidget>> setProviders() async {
  // 데이터 소스
  final apiSet = <LoginMethod, AuthApi>{
    LoginMethod.google: GoogleAuthApi(),
    LoginMethod.apple: AppleAuthApi(),
  };
  final userLocalDataSource = UserLocalDataSource(const FlutterSecureStorage());
  final tokenLocalDataSource = TokenLocalDataSource.instance;
  final kakaoAuthApi = KakaoAuthApi.instance;
  final kakaoUserApi = KakaoUserApi.instance;
  final firebaseAuthRemoteDataSource = FirebaseAuthRemoteDataSource();

  // 레포지토리
  final oauthRepository = OAuthRepositoryImpl(apiSet, userLocalDataSource);
  final kakaoRepository = KakaoAuthRepositoryImpl(
      kakaoAuthApi, kakaoUserApi, firebaseAuthRemoteDataSource);
  final tokenRepository = TokenRepositoryImpl(tokenLocalDataSource);
  final userRepository = UserRepositoryImpl(userLocalDataSource);

  // 유스케이스
  final socialLoginUseCase = SocialLoginUseCase(oauthRepository);
  final kakaoLoginUseCase =
      KakaoLoginUseCase(kakaoRepository, tokenRepository, userRepository);
  final logoutUseCase = LogoutUseCase(tokenRepository, kakaoRepository);

  // 뷰모델
  final List<SingleChildWidget> viewModels = [
    ChangeNotifierProvider<AuthViewModel>(
      create: (context) => AuthViewModel(
        socialLoginUseCase,
        kakaoLoginUseCase,
        logoutUseCase,
      ),
    ),
  ];

  return viewModels;
}
