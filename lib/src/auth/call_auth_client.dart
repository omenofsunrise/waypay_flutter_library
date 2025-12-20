import 'dart:convert';

import 'package:http/http.dart' as http;

import 'models.dart';

class CallAuthClient {
  CallAuthClient({http.Client? httpClient, String? baseUrl})
    : _client = httpClient ?? http.Client(),
      _baseUrl = (baseUrl ?? 'http://95.163.226.24:8080').replaceAll(
        RegExp(r'/+$'),
        '',
      );

  final http.Client _client;
  final String _baseUrl;

  Uri _buildUri(String path) => Uri.parse('$_baseUrl$path');

  Future<CallAuthInitResponse> initiate({
    required String phone,
    required String userType,
  }) async {
    final uri = _buildUri('/auth/call/initiate');
    final response = await _client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'phone': phone, 'user_type': userType}),
    );
    _throwIfNotOk(response);
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return CallAuthInitResponse.fromJson(json);
  }

  Future<CallAuthConfirmResponse> confirm({
    required String checkId,
    required String phone,
    required String userType,
  }) async {
    final uri = _buildUri('/auth/call/confirm');
    final response = await _client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'check_id': checkId,
        'phone': phone,
        'user_type': userType,
      }),
    );
    _throwIfNotOk(response);
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return CallAuthConfirmResponse.fromJson(json);
  }

  Future<AuthTokens> refresh(AuthTokens tokens) async {
    final uri = _buildUri('/auth/refresh');
    final response = await _client.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(tokens.toJson()),
    );
    _throwIfNotOk(response);
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return AuthTokens.fromJson(json);
  }

  void _throwIfNotOk(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) return;
    throw Exception(
      'Auth request failed (${response.statusCode}): ${response.body}',
    );
  }
}
