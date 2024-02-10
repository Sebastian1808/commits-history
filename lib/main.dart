import 'package:commits_history/ui/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

import 'manager/app_state_manager.dart';

void main() {
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
              // TODO: Add the AppRouter provider
            ],
            child: Builder(
              builder: (BuildContext context) {
                return const PlatformApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Commits History',
                  home: DashboardScreen(),
                );
              },
            )
        )
    );
  }
}
