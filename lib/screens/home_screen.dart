import 'package:eko_messenger/providers/auth.dart';
import 'package:eko_messenger/widgets/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      drawer: const SideBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            auth.logout();
          },
          child: const Text('Logout'),
        ),
      ),
    );
  }
}
