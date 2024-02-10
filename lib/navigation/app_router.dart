import 'package:go_router/go_router.dart';

import '../manager/app_state_manager.dart';
import '../ui/dashboard_screen.dart';

class AppRouter {
  final AppStateManager appStateManager;

  AppRouter(this.appStateManager);

  late final router = GoRouter(
    debugLogDiagnostics: false,
    initialLocation: '/',
    refreshListenable: appStateManager,
    routes: [
      // TODO: Add the login flow routes
      GoRoute(
        name: 'dashboard',
        path: '/dashboard',
        pageBuilder: (context, state) => NoTransitionPage<void>(
          key: state.pageKey,
          child: const DashboardScreen(),
        ),
      ),
    ],
    // TODO: Add the redirect logic
  );
}