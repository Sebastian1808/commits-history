import 'package:commits_history/theme/commits_history_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

import 'manager/app_state_manager.dart';
import 'navigation/app_router.dart';

Future<void> main() async {
  await dotenv.load(
      fileName: '.env'
  );

  runApp(const CommitsHistory());
}

class CommitsHistory extends StatefulWidget {
  const CommitsHistory({super.key});

  @override
  State<CommitsHistory> createState() => _CommitsHistoryState();
}

class _CommitsHistoryState extends State<CommitsHistory> {
  final _appStateManager = AppStateManager();

  @override
  Widget build(BuildContext context) {
    return PlatformProvider(
        settings: PlatformSettingsData(
          platformStyle: const PlatformStyleData(android: PlatformStyle.Material),
        ),
        builder: (context) => MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (context) => _appStateManager,
              ),
              Provider<AppRouter>(
                create: (context) => AppRouter(_appStateManager),
              ),
            ],
            child: Builder(
              builder: (BuildContext context) {
                final router = context.read<AppRouter>().router;

                return PlatformApp.router(
                  routeInformationProvider: router.routeInformationProvider,
                  routeInformationParser: router.routeInformationParser,
                  routerDelegate: router.routerDelegate,
                  debugShowCheckedModeBanner: false,
                  title: 'Commits History',
                  material: (_, __) =>
                      MaterialAppRouterData(theme: CommitsHistoryMaterialTheme.light()),
                  cupertino: (_, __) =>
                      CupertinoAppRouterData(theme: CommitsHistoryCupertinoTheme.light()),
                );
              },
            )
        )
    );
  }
}