import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/view/sign_in_page.dart';
import '../../features/home/view/home_page.dart';
import '../../features/splash/view/splash_page.dart';

GoRouter createRouter() {
  return GoRouter(
    initialLocation: '/',
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (BuildContext context, GoRouterState state) => const SplashPage(),
      ),
      GoRoute(
        path: '/auth',
        name: 'auth',
        builder: (BuildContext context, GoRouterState state) => const SignInPage(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (BuildContext context, GoRouterState state) => const HomePage(),
      ),
    ],
  );
}


