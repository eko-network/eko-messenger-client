import 'package:eko_messanger/auth/secure_auth_store.dart';
import 'package:eko_messanger/database/database.dart';
import 'package:eko_messanger/database/daos/ecp/storage.dart';
import 'package:eko_messanger/providers/database.dart';
import 'package:eko_messanger/providers/device_name_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ecp/auth.dart';
import 'package:ecp/ecp.dart';

part '../generated/providers/auth.g.dart';

class AuthNotifier extends ChangeNotifier {
  AuthNotifier(this._auth, this._db);

  final Auth _auth;
  final AppDatabase _db;

  bool get isAuthenticated => _auth.isAuthenticated;

  Future<void> login({
    required String email,
    required String password,
    required Uri url,
  }) async {
    await _auth.login(email: email, password: password, url: url);
    notifyListeners();
  }

  Future<void> logout() async {
    await _auth
        .logout(); // This clears auth & ECP storage (users, sessions, keys, etc.)
    // Clear app-specific data not handled by auth.logout()
    await _db.delete(_db.messages).go();
    await _db.delete(_db.conversations).go();
    await _db.delete(_db.contacts).go();
    notifyListeners();
  }

  Future<void> initialize() async {
    await _auth.initialize();
  }

  AuthInfo? get info => _auth.info;
  http.Client get client => _auth.client;
  Storage get ecpStorage => _auth.ecpStorage;
  Future<String> token() async {
    return await _auth.getValidAccessToken();
  }
}

@Riverpod(keepAlive: true)
AuthNotifier auth(Ref ref) {
  final deviceName = ref.watch(deviceNameProvider);
  final db = ref.read(appDatabaseProvider);
  return AuthNotifier(
    Auth(
      SecureAuthStore(db),
      ecpStorage: DriftStorage(db),
      deviceName: deviceName,
    ),
    db,
  );
}
