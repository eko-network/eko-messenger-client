import 'package:eko_messanger/providers/auth.dart';
import 'package:eko_messanger/screens/chat/adaptive_chat_layout.dart';
import 'package:eko_messanger/screens/login_screen.dart';
import 'package:eko_messanger/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part '../generated/providers/app_router.g.dart';

@riverpod
GoRouter router(Ref ref) {
  final authNotifier = ref.watch(authProvider);

  return GoRouter(
    initialLocation: '/',
    refreshListenable: authNotifier, // Will rebuild on auth change
    redirect: (BuildContext context, GoRouterState state) {
      final onLoginPage = state.matchedLocation == '/login';
      final isLoggedIn = authNotifier.isAuthenticated;

      if (onLoginPage) {
        if (isLoggedIn) {
          return '/';
        } else {
          return null;
        }
      }
      if (!isLoggedIn) {
        return '/login';
      }
      return null;
    },
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(path: '/', builder: (context, state) => AdaptiveChat()),
      GoRoute(path: '/settings', builder: (context, state) => const Settings()),
      GoRoute(
        path: '/chats/:id',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return AdaptiveChat(selectedConversationId: id);
        },
      ),
    ],
  );
}
