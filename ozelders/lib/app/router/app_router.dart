import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/view/home_page.dart';
import '../../features/splash/view/splash_page.dart';
import '../../features/teacher/view/teacher_login_page.dart';
import '../../features/student/view/student_login_page.dart';
import '../../features/teacher/view/teacher_panel_page.dart';
import '../../features/student/view/student_panel_page.dart';

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
        path: '/home',
        name: 'home',
        builder: (BuildContext context, GoRouterState state) => const HomePage(),
      ),
      GoRoute(
        path: '/auth',
        name: 'auth',
        builder: (BuildContext context, GoRouterState state) => const HomePage(), // Geçici olarak HomePage'e yönlendir
      ),
      GoRoute(
        path: '/teacher/login',
        name: 'teacher_login',
        builder: (BuildContext context, GoRouterState state) => const TeacherLoginPage(),
      ),
      GoRoute(
        path: '/student/login',
        name: 'student_login',
        builder: (BuildContext context, GoRouterState state) => const StudentLoginPage(),
      ),
      GoRoute(
        path: '/teacher/panel',
        name: 'teacher_panel',
        builder: (BuildContext context, GoRouterState state) => const TeacherPanelPage(),
      ),
      GoRoute(
        path: '/student/panel',
        name: 'student_panel',
        builder: (BuildContext context, GoRouterState state) => const StudentPanelPage(),
      ),
    ],
  );
}


