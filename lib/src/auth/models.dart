import 'dart:convert';

class CallAuthInitResponse {
  final String callPhone;
  final String checkId;

  const CallAuthInitResponse({required this.callPhone, required this.checkId});

  factory CallAuthInitResponse.fromJson(Map<String, dynamic> json) {
    return CallAuthInitResponse(
      callPhone: json['call_phone']?.toString() ?? '',
      checkId: json['check_id']?.toString() ?? '',
    );
  }
}

class CallAuthConfirmResponse {
  final String accessToken;
  final String refreshToken;
  final String status;
  final Map<String, dynamic>? user;

  const CallAuthConfirmResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.status,
    required this.user,
  });

  factory CallAuthConfirmResponse.fromJson(Map<String, dynamic> json) {
    return CallAuthConfirmResponse(
      accessToken: json['access_token']?.toString() ?? '',
      refreshToken: json['refresh_token']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      user: json['user'] is Map<String, dynamic>
          ? json['user'] as Map<String, dynamic>
          : null,
    );
  }

  bool get isConfirmed => status == 'AUTH_CONFIRMED';
  bool get isPending => status == 'AUTH_PENDING';
}

class AuthTokens {
  final String accessToken;
  final String refreshToken;

  const AuthTokens({required this.accessToken, required this.refreshToken});

  factory AuthTokens.fromJson(Map<String, dynamic> json) {
    return AuthTokens(
      accessToken: json['access_token']?.toString() ?? '',
      refreshToken: json['refresh_token']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'access_token': accessToken,
    'refresh_token': refreshToken,
  };

  @override
  String toString() => jsonEncode(toJson());
}
