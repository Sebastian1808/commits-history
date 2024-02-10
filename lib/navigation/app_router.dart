import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../manager/app_state_manager.dart';
import '../ui/auth/login_screen.dart';
import '../ui/dashboard_screen.dart';
import '../ui/splash_screen.dart';

class AppRouter {
  final AppStateManager appStateManager;

  AppRouter(this.appStateManager);

  late final router = GoRouter(
    debugLogDiagnostics: false,
    initialLocation: '/',
    refreshListenable: appStateManager,
    routes: [
      GoRoute(
          name: 'splash',
          path: '/',
          builder: (context, state) => const SplashScreen()
      ),
      GoRoute(
        name: 'login',
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: 'dashboard',
        path: '/dashboard',
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const DashboardScreen(),
        ),
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {

      final inSplash = state.fullPath == '/';

      final inLogging = state.fullPath == '/login';
      const loginLoc = '/login';


      const dashboardLoc = '/dashboard';

      final loggedIn = appStateManager.isLoggedIn;

      final noLoggedInRoutes = [
        inSplash,
        inLogging
      ];

      // redirect to the welcome page if the user is not logged in or to the
      //  dashboard if the user is logged in
      if (appStateManager.isInitialized) {
        if (inSplash) {
          return loginLoc;
        }

        if (!loggedIn) {

          if (noLoggedInRoutes.every((element) => !element) ) {
            return loginLoc;
          }
        } else {
          if (noLoggedInRoutes.any((element) => element)){
            return dashboardLoc;
          }
        }
      }

      return null;
    },
  );
}