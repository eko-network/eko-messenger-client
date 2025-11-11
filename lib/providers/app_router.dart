import 'package:eko_messanger/screens/home_screen.dart';
import 'package:eko_messanger/screens/login_screen.dart';
import 'package:eko_messanger/utils/client.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authStateProvider = StreamProvider<bool>((ref) {
  // might not need this
  ecp.initialize();
  return ecp.authStream;
});

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);
  return GoRouter(
    initialLocation: '/',
    redirect: (BuildContext context, GoRouterState state) {
      final onLoginPage = state.matchedLocation == '/login';
      if (authState.isLoading) {
        return null;
      }

      if (authState.hasError) {
        return '/login';
      }

      final isLoggedIn = authState.valueOrNull ?? false;

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
      GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
    ],
  );
});
