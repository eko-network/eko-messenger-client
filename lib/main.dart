import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:eko_messanger/providers/auth.dart';
import 'package:eko_messanger/providers/device_name_provider.dart';
import 'package:eko_messanger/providers/message_polling.dart';
import 'package:eko_messanger/utils/device_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eko_messanger/providers/app_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:eko_messanger/utils/constants.dart' as c;
import 'package:eko_messanger/utils/push_notifications.dart';
import 'package:sqlcipher_flutter_libs/sqlcipher_flutter_libs.dart';
import 'package:sqlite3/open.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  open.overrideFor(OperatingSystem.android, openCipherOnAndroid);
  final deviceName = await getDeiviceName();
  final container = ProviderContainer(
    overrides: [deviceNameProvider.overrideWithValue(deviceName)],
  );
  await container.read(authProvider).initialize();

  final bool isMobile = Platform.isAndroid || Platform.isIOS;
  if (isMobile) {
    debugPrint("mobile init");
    final firebaseApp = await _initializeFirebase();
    if (firebaseApp != null) {
      await configureFirebaseMessaging(
        authenticatedClient: () async => container.read(authProvider).client,
        onToken: (token) async {
          if (kDebugMode) {
            debugPrint('FCM token: $token');
          }
        },
      );
    }
  }
  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

Future<FirebaseApp?> _initializeFirebase() async {
  try {
    return await Firebase.initializeApp();
  } catch (error, stackTrace) {
    if (kDebugMode) {
      debugPrint('Firebase failed to initialize: $error');
      debugPrint('$stackTrace');
    }
    return null;
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize message polling
    ref.watch(messagePollingProvider);

    final router = ref.watch(routerProvider);
    // return ShadApp.custom(
    //   themeMode: ThemeMode.dark,
    //   darkTheme: ShadThemeData(
    //     brightness: Brightness.dark,
    //     colorScheme: const ShadGrayColorScheme.dark(),
    //   ),
    //   appBuilder: (context) {
    //     return MaterialApp.router(
    //       theme: Theme.of(context),
    //       routerConfig: router,
    //     );
    //   },
    // );
    return ShadApp.router(
      themeMode: ThemeMode.dark,
      darkTheme: ShadThemeData(
        brightness: Brightness.dark,
        colorScheme: ShadZincColorScheme.dark(
          custom: {
            c.grayMessageColorKey: Color(0xff3B3B3B),
            c.primaryColorKey: Color(0xff145CEF),
          },
        ),
      ),
      routerConfig: router,
    );
  }
}
