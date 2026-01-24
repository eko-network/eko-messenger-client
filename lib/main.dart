import 'package:eko_messenger/providers/auth.dart';
import 'package:eko_messenger/providers/device_name_provider.dart';
import 'package:eko_messenger/providers/messages.dart';
import 'package:eko_messenger/utils/device_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:eko_messenger/providers/app_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:eko_messenger/utils/constants.dart' as c;
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

  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize message polling
    ref.watch(messagePollingProvider);

    final router = ref.watch(routerProvider);
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
