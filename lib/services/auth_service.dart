import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref.watch(clientProvider));
});

class AuthService {
  final Client _client;
  late final Account _account;

  AuthService(this._client) {
    _account = Account(_client);
  }

  Future<User?> getUser() async {
    try {
      return await _account.get();
    } catch (e) {
      return null;
    }
  }

  Future<Session> login({
    required String email,
    required String password,
  }) async {
    return _account.createEmailSession(email: email, password: password);
  }

  Future loginWithGoogle() async {
    return _account.createOAuth2Session(provider: 'google');
  }

  Future<Session> signUp({
    required String email,
    required String password,
    String? name,
  }) async {
    return _account
        .create(
            userId: ID.unique(), email: email, password: password, name: name)
        .then((value) =>
            _account.createEmailSession(email: email, password: password));
  }
}
