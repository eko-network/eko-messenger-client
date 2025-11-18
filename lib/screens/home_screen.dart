import 'package:ecp/ecp.dart';
import 'package:eko_messanger/providers/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: authState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
        data: (_) => Center(
          child: ElevatedButton(
            onPressed: () {
              ecp.logout();
            },
            child: const Text('Logout'),
          ),
        ),
      ),
    );
  }
}
