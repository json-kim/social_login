import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:social_login/data/local/token_local_data_source.dart';
import 'package:social_login/data/local/user_local_data_source.dart';
import 'package:social_login/data/remote/auth/apple_auth_api.dart';
import 'package:social_login/data/remote/auth/google_auth_api.dart';
import 'package:social_login/data/remote/auth/kakao_auth_api.dart';
import 'package:social_login/data/remote/auth/kakao_user_api.dart';
import 'package:social_login/data/remote/auth/naver_auth_api.dart';
import 'package:social_login/data/remote/auth/naver_user_api.dart';
import 'package:social_login/data/remote/firebase/firebase_auth_remote_data_source.dart';
import 'package:social_login/data/repository/apple_auth_repository_impl.dart';
import 'package:social_login/data/repository/fauth_repository_impl.dart';
import 'package:social_login/data/repository/google_auth_repository_impl.dart';
import 'package:social_login/data/repository/kakao_auth_repository_impl.dart';
import 'package:social_login/data/repository/naver_auth_repository_impl.dart';
import 'package:social_login/data/repository/token_repository_impl.dart';
import 'package:social_login/domain/usecase/auth/apple_login_use_case.dart';
import 'package:social_login/domain/usecase/auth/google_login_use_case.dart';
import 'package:social_login/domain/usecase/auth/kakao_login_use_case.dart';
import 'package:social_login/domain/usecase/auth/logout_use_case.dart';
import 'package:social_login/domain/usecase/auth/naver_login_use_case.dart';
import 'package:social_login/presentation/auth/auth_view_model.dart';

Future<List<SingleChildWidget>> setProviders() async {
  // 데이터 소스
  final userLocalDataSource = UserLocalDataSource(const FlutterSecureStorage());
  final tokenLocalDataSource = TokenLocalDataSource.instance;
  final firebaseAuthRemoteDataSource = FirebaseAuthRemoteDataSource();
  final kakaoAuthApi = KakaoAuthApi.instance;
  final kakaoUserApi = KakaoUserApi.instance;
  final naverAuthApi = NaverAuthApi.instance;
  final naverUserApi = NaverUserApi.instance;
  final googleAuthApi = GoogleAuthApi();
  final appleAuthApi = AppleAuthApi();

  // 레포지토리
  final fauthRepository = FAuthRepositoryImpl(firebaseAuthRemoteDataSource);
  final tokenRepository = TokenRepositoryImpl(tokenLocalDataSource);
  final kakaoRepository = KakaoAuthRepositoryImpl(
    kakaoAuthApi,
    kakaoUserApi,
    tokenLocalDataSource,
  );
  final naverRepository = NaverAuthRepositoryImpl(
    naverAuthApi,
    naverUserApi,
    tokenLocalDataSource,
  );
  final googleRepository = GoogleAuthRepositoryImpl(googleAuthApi);
  final appleRepository = AppleAuthRepositoryImpl(appleAuthApi);

  // 유스케이스
  final kakaoLoginUseCase = KakaoLoginUseCase(
    kakaoRepository,
    fauthRepository,
  );
  final naverLoginUseCase = NaverLoginUseCase(
    naverRepository,
    fauthRepository,
  );
  final googleLoginUseCase = GoogleLoginUseCase(googleRepository);
  final appleLoginUseCase = AppleLoginUseCase(appleRepository);
  final logoutUseCase = LogoutUseCase(
    googleRepository,
    appleRepository,
    kakaoRepository,
    naverRepository,
  );

  // 뷰모델
  final List<SingleChildWidget> viewModels = [
    ChangeNotifierProvider<AuthViewModel>(
      create: (context) => AuthViewModel(
        googleLoginUseCase,
        appleLoginUseCase,
        kakaoLoginUseCase,
        naverLoginUseCase,
        logoutUseCase,
      ),
    ),
  ];

  return viewModels;
}
