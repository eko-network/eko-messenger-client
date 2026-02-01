import 'dart:io';
import 'package:eko_messenger/auth/secure_auth_store.dart';
import 'package:eko_messenger/database/database.dart';
import 'package:eko_messenger/database/daos/ecp/storage.dart';
import 'package:eko_messenger/providers/database.dart';
import 'package:eko_messenger/providers/device_name_provider.dart';
import 'package:eko_messenger/providers/push.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:ecp/auth.dart';
import 'package:ecp/ecp.dart';

part '../generated/providers/auth.g.dart';

class AuthNotifier extends ChangeNotifier {
  AuthNotifier(this._auth, this._authStore, this._db, this._ref);

  final Auth _auth;
  final SecureAuthStore _authStore;
  final AppDatabase _db;
  final Ref _ref;
  EcpClient? _ecpClient;
  bool _isLoggingOut = false;

  bool get isAuthenticated => _auth.isAuthenticated;
  EcpClient? get ecpClient => _ecpClient;

  Future<void> login({
    required String email,
    required String password,
    required Uri url,
  }) async {
    await _auth.login(email: email, password: password, url: url);
    await _initializeEcpClient();
    await _initializeMessagingIfSupported();
    notifyListeners();
  }

  Future<void> logout() async {
    if (_isLoggingOut) return;
    _isLoggingOut = true;
    
    try {
      _ecpClient = null;
      
      // Clear app-specific data not handled by auth.logout()
      await _db.delete(_db.messages).go();
      await _db.delete(_db.conversations).go();
      await _db.delete(_db.contacts).go();
      
      await _auth.logout();
      
      await _authStore.clearDatabasePassword();
      
      notifyListeners();
    } finally {
      _isLoggingOut = false;
    }
  }

  Future<void> initialize() async {
    await _auth.initialize();
    if (_auth.isAuthenticated) {
      await _initializeEcpClient();
      await _initializeMessagingIfSupported();
    }
  }

  Future<void> _initializeMessagingIfSupported() async {
    // Only initialize on platforms that support push messaging
    final bool shouldInitialize =
        Platform.isAndroid || Platform.isIOS || Platform.isLinux;

    if (shouldInitialize) {
      debugPrint("Initializing push messaging after authentication");
      try {
        // Just read the provider to trigger initialization
        _ref.read(pushProvider);
      } catch (e) {
        debugPrint("Error initializing push messaging: $e");
      }
    }
  }

  AuthInfo? get info => _auth.info;
  http.Client get client => _auth.client;
  Storage get ecpStorage => _auth.ecpStorage;
  Future<String> token() async {
    return await _auth.getValidAccessToken();
  }

  Future<void> _initializeEcpClient() async {
    final authInfo = _auth.info;
    if (authInfo == null) {
      _ecpClient = null;
      return;
    }

    _ecpClient = await EcpClient.build(
      storage: _auth.ecpStorage,
      client: _auth.client,
      me: authInfo.actor,
      did: authInfo.did,
      tokenGetter: token,
    );
  }
}

@Riverpod(keepAlive: true)
AuthNotifier auth(Ref ref) {
  final deviceName = ref.watch(deviceNameProvider);
  final db = ref.read(appDatabaseProvider);
  final authStore = SecureAuthStore(db);
  
  late final AuthNotifier authNotifier;
  
  authNotifier = AuthNotifier(
    Auth(
      authStore,
      ecpStorage: DriftStorage(db),
      deviceName: deviceName,
      onSessionExpired: () {
        debugPrint('Session expired callback triggered - logging out');
        authNotifier.logout();
      },
    ),
    authStore,
    db,
    ref,
  );
  
  return authNotifier;
}
