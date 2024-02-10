import 'package:commits_history/ui/auth/components/custom_app_bar_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../helpers/launch_web_view.dart';
import '../../theme/style.dart';
import 'components/custom_card_wrapper.dart';
import 'components/custom_button.dart';

class HowToGetAuthTokenScreen extends StatefulWidget {
  const HowToGetAuthTokenScreen({super.key});

  @override
  State<HowToGetAuthTokenScreen> createState() => _HowToGetAuthTokenScreenState();
}

class _HowToGetAuthTokenScreenState extends State<HowToGetAuthTokenScreen> {
  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: customAppBarBackButton('How To Get Personal Access Token', context),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/backgrounds/screens_background_grey.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          minimum: const EdgeInsets.only(
              top: 5.0,
              right: 20.0,
              left: 20.0,
              bottom: 10.0
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.88,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomCardWrapper(
                    child: Text('🔎 Steps to get your Personal Access Token',
                        style: GoogleFonts.nunito(
                            textStyle: Styles.headline2
                        ),
                        textAlign: TextAlign.center
                    ),
                  ),
                  CustomCardWrapper(
                    child: Text(' 1. Login with your user or a user with access to the repository you want to see the commit history.',
                        style: GoogleFonts.nunito(
                            textStyle: Styles.bodyTextBoldJumbo
                        ),
                        textAlign: TextAlign.center
                    ),
                  ),
                  CustomCardWrapper(
                    child: Text('2. Go to the account settings ',
                        style: GoogleFonts.nunito(
                            textStyle: Styles.bodyTextBoldJumbo
                        ),
                        textAlign: TextAlign.center
                    ),
                  ),
                  CustomCardWrapper(
                    child: Text('3. Select the last option on the left menu, "< > Developer Settings"',
                        style: GoogleFonts.nunito(
                            textStyle: Styles.bodyTextBoldJumbo
                        ),
                        textAlign: TextAlign.center
                    ),
                  ),
                  CustomCardWrapper(
                    child: Text('4. Again in the new menu that appears on the left select the option '
                        '\n "🔑 Personal Access Token" \n-> Tokens(Classic)',
                        style: GoogleFonts.nunito(
                            textStyle: Styles.bodyTextBoldJumbo
                        ),
                        textAlign: TextAlign.center
                    ),
                  ),
                  CustomCardWrapper(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Note',
                            style: GoogleFonts.nunito(
                                textStyle: Styles.headline3,
                                color: Colors.red
                            ),
                            textAlign: TextAlign.center
                        ),
                        Text("If you don't have any token you can generate "
                            "a new one, but if you already have tokens generated before "
                            "to be able to see your token you need to re-generate the token.",
                            style: GoogleFonts.nunito(
                                textStyle: Styles.bodyTextBoldJumbo
                            ),
                            textAlign: TextAlign.center
                        ),
                      ],
                    ),
                  ),
                  CustomButton(
                      onPressed: () => launchInWebView(Uri.parse('https://github.com/settings/tokens')),
                      textButton: 'Go to GitHub',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}