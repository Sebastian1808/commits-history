import 'package:commits_history/manager/app_state_manager.dart';
import 'package:commits_history/ui/auth/components/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text('Dashboard'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: Text('Dashboard'),
          ),
          const SizedBox(height: 20.0),
          CustomButton(
            onPressed: () => context.read<AppStateManager>().logout(),
              textButton: 'Logout',
          ),
        ],
      ),
    );
  }
}
