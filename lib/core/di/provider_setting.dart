import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:social_login/data/remote/auth/apple_auth_api.dart';
import 'package:social_login/data/remote/auth/google_auth_api.dart';
import 'package:social_login/data/repository/oauth_repository_impl.dart';
import 'package:social_login/domain/usecase/auth/logout_use_case.dart';
import 'package:social_login/domain/usecase/auth/social_login_use_case.dart';
import 'package:social_login/presentation/auth/auth_view_model.dart';

Future<List<SingleChildWidget>> setProviders() async {
  // 데이터 소스
  final apiSet = {
    LoginMethod.google: GoogleAuthApi(),
    LoginMethod.apple: AppleAuthApi(),
  };

  // 레포지토리
  final oauthRepository = OAuthRepositoryImpl(apiSet);

  // 유스케이스
  final socialLoginUseCase = SocialLoginUseCase(oauthRepository);
  final logoutUseCase = LogoutUseCase(oauthRepository);

  // 뷰모델
  final List<SingleChildWidget> viewModels = [
    ChangeNotifierProvider<AuthViewModel>(
      create: (context) => AuthViewModel(
        socialLoginUseCase,
        logoutUseCase,
      ),
    ),
  ];

  return viewModels;
}
