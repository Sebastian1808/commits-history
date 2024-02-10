import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../manager/app_state_manager.dart';
import '../ui/auth/welcome_screen.dart';
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
        name: 'welcome',
        path: '/welcome',
        builder: (context, state) => const WelcomeScreen(),
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

      final inWelcome = state.fullPath == '/welcome';
      const welcomeLoc = '/welcome';


      const dashboardLoc = '/dashboard';

      final loggedIn = appStateManager.isLoggedIn;

      final noLoggedInRoutes = [
        inSplash,
        inWelcome
      ];

      // redirect to the welcome page if the user is not logged in or to the
      //  dashboard if the user is logged in
      if (appStateManager.isInitialized) {
        if (inSplash) {
          return welcomeLoc;
        }

        if (!loggedIn) {

          if (noLoggedInRoutes.every((element) => !element) ) {
            return welcomeLoc;
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