abstract class AuthApi {
  Future<void> signOut();
}

abstract class SdkApi {
  Future<OAuthCredential> signIn();
}
