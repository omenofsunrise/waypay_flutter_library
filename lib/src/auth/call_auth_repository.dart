import 'call_auth_client.dart';
import 'models.dart';

abstract class CallAuthRepository {
  Future<CallAuthInitResponse> initiate({
    required String phone,
    required String userType,
  });

  Future<CallAuthConfirmResponse> confirm({
    required String checkId,
    required String phone,
    required String userType,
  });

  Future<AuthTokens> refresh(AuthTokens tokens);
}

class DefaultCallAuthRepository implements CallAuthRepository {
  DefaultCallAuthRepository({
    required CallAuthClient sharedClient,
    CallAuthClient? legacyClient,
    Set<String> legacyUserTypes = const {'employee'},
  }) : _sharedClient = sharedClient,
       _legacyClient = legacyClient,
       _legacyUserTypes = legacyUserTypes;

  final CallAuthClient _sharedClient;
  final CallAuthClient? _legacyClient;
  final Set<String> _legacyUserTypes;

  bool _useLegacy(String userType) =>
      _legacyClient != null && _legacyUserTypes.contains(userType);

  @override
  Future<CallAuthInitResponse> initiate({
    required String phone,
    required String userType,
  }) {
    final client = _useLegacy(userType) ? _legacyClient! : _sharedClient;
    return client.initiate(phone: phone, userType: userType);
  }

  @override
  Future<CallAuthConfirmResponse> confirm({
    required String checkId,
    required String phone,
    required String userType,
  }) {
    final client = _useLegacy(userType) ? _legacyClient! : _sharedClient;
    return client.confirm(checkId: checkId, phone: phone, userType: userType);
  }

  @override
  Future<AuthTokens> refresh(AuthTokens tokens) {
    return _sharedClient.refresh(tokens);
  }
}
