import 'package:eko_messanger/database/database.dart';
import 'package:eko_messanger/database/drift_storage.dart';
import 'package:eko_messanger/providers/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ecp/ecp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ECPClient.initialize(
    storage: DriftStorage(AppDatabase()),
    baseUrl: Uri.parse("http://localhost:3000/"),
    deviceName: "test-device",
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(routerConfig: router);
  }
}
