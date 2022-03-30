import 'package:social_login/data/remote/firebase/firebase_auth_remote_data_source.dart';
import 'package:social_login/domain/model/user_response.dart';
import 'package:social_login/domain/repository/fauth_repository.dart';

class FAuthRepositoryImpl implements FAuthRepository {
  final FirebaseAuthRemoteDataSource _firebaseAuthRemoteDataSource;

  FAuthRepositoryImpl(this._firebaseAuthRemoteDataSource);

  @override
  Future<String> issueCustomToken(UserResponse userResponse) async {
    return await _firebaseAuthRemoteDataSource.requestCustomToken(userResponse);
  }
}
