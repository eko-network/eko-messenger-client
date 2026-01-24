import 'package:eko_messenger/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Settings extends ConsumerWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        title: Text('Settings'),
      ),
      body: Center(
        child: ShadButton(
          child: Text('Logout'),
          onPressed: () => ref.read(authProvider).logout(),
        ),
      ),
    );
  }
}
