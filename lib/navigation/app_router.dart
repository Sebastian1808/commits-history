import 'package:commits_history/ui/auth/how_to_get_auth_token_screen.dart';
import 'package:commits_history/ui/auth/selected_project_screen.dart';
import 'package:commits_history/ui/commits/commit_detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../manager/app_state_manager.dart';
import '../ui/auth/welcome_screen.dart';
import '../ui/commits/dashboard_screen.dart';
import '../ui/splash_screen.dart';

class AppRouter {
  final AppStateManager appStateManager;

  AppRouter(this.appStateManager);

  late final router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    refreshListenable: appStateManager,
    routes: <RouteBase>[
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
          name: 'howToGetAuthToken',
          path: '/how-to-get-auth-token',
          builder: (context, state) => const HowToGetAuthTokenScreen(),
      ),
      GoRoute(
        name: 'selectProject',
        path: '/select-project',
        builder: (context, state) => const SelectProjectScreen(),
      ),
      GoRoute(
        name: 'dashboard',
        path: '/dashboard',
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const DashboardScreen(),
        ),
      ),
      GoRoute(
        name: 'commitDetail',
        path: '/commit-detail',
        builder: (context, state) => CommitDetailScreen(commit: state.extra as Map<String, dynamic>),
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {

      final inSplash = state.fullPath == '/';

      final inWelcome = state.fullPath == '/welcome';
      const welcomeLoc = '/welcome';

      final inHowToGetAuthToken = state.fullPath == '/how-to-get-auth-token';

      final inSelectProject = state.fullPath == '/select-project';
      const selectProjectLoc = '/select-project';

      const dashboardLoc = '/dashboard';

      final loggedIn = appStateManager.isLoggedIn;
      final isProjectSelected = appStateManager.isProjectSelected;

      final noLoggedInRoutes = [
        inSplash,
        inWelcome,
        inHowToGetAuthToken,
        inSelectProject
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
            if (!isProjectSelected) {

              return selectProjectLoc;
            } else {

              return dashboardLoc;
            }
          }
        }
      }

      return null;
    },
  );
}