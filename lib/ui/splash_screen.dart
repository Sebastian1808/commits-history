import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import '../manager/app_state_manager.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 500), () {
      context.read<AppStateManager>().initializeApp();
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: Container(
        width: double.infinity,
        color: Colors.white,
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Image(
                  height: 250,
                  image: AssetImage('assets/logos/commits_history_logo.png'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}