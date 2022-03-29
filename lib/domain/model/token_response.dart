class TokenResponse {
  final String accessToken;
  final String? refreshToken;

  TokenResponse({required this.accessToken, required this.refreshToken});

  factory TokenResponse.fromJson(Map<String, dynamic> json) {
    return TokenResponse(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }

  @override
  String toString() =>
      'TokenResponse(accessToken: $accessToken, refreshToken: $refreshToken)';
}
