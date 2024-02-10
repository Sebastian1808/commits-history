import 'package:commits_history/api/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../api/auth/auth_services.dart';
import '../../manager/app_state_manager.dart';
import '../../theme/style.dart';
import 'components/custom_app_bar.dart';
import 'components/custom_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final GlobalKey<FormState> _formValidator = GlobalKey<FormState>();
  final TextEditingController _controllerToken = TextEditingController();

  // State of loading for the buttons
  bool isLoadingThisCommits = false;
  bool isLoadingOtherCommits = false;

  @override
  void dispose() {
    _controllerToken.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: customAppBar('Welcome to Commits History', context),
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
                  cardWrapper(
                    Text(
                      '📖 In this app you can see the commit history of your GitHub repositories.\n 🚀 With help of GitHub APIs! 🚀 ',
                      style: GoogleFonts.nunito(
                        textStyle: Styles.headline3,
                      ),
                      textAlign: TextAlign.center,
                    )
                  ),
                  Image.asset('assets/logos/login_decoration.png'),
                  cardWrapper(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "You can view any of your GitHub repositories or you can also see an example of the commit history of this application's repository. 📚",
                            style: GoogleFonts.nunito(
                              textStyle: Styles.headline3,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 15.0),
                          isLoadingThisCommits
                              ? const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey)
                                  ),
                                )
                              : CustomButton(
                                onPressed: () => viewThisRepoCommits(context),
                                textButton: 'View Commits For This Repo',
                              )
                        ],
                      ),

                  ),
                  cardWrapper(
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Form(
                            key: _formValidator,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                PlatformTextFormField(
                                  textInputAction: TextInputAction.next,
                                  hintText: 'Personal Access Token',
                                  controller: _controllerToken,
                                  cursorColor: Colors.blueGrey,
                                  cupertino: (_, __) => CupertinoTextFormFieldData(
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(width: 1.0, color: Colors.grey),
                                        ),
                                      )
                                  ),
                                  material: (_, __) => MaterialTextFormFieldData(
                                    decoration: const InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.grey)
                                        )
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'The Personal Access Token cannot be empty';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                "You don't know how to get a \npersonal access token? 👉",
                                style: GoogleFonts.nunito(
                                  textStyle: Styles.bodyText1,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w500,
                                )
                            ),
                            PlatformTextButton(
                                child: Text(
                                    'Click here',
                                    style: GoogleFonts.nunito(
                                      textStyle: Styles.bodyTextBold,
                                      color: Colors.blueGrey,
                                      decoration: TextDecoration.underline,
                                    )
                                ),
                                onPressed: () {
                                 // TODO: Make section to show how to get a personal access token
                                }
                            )
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        isLoadingOtherCommits
                            ? const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey)
                                ),
                              )
                            : CustomButton(
                                onPressed: () => _submitForm(context),
                                textButton: 'View My Repos Commits'
                        ),
                      ],
                    )
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget cardWrapper(Widget child) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(width: 1, color: Colors.white)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }

  void viewThisRepoCommits(context) async {
    setState(() => isLoadingThisCommits = true);

    Response response = await AuthServices().login(
      token: dotenv.env['PERSONAL_ACCESS_TOKEN'] ?? '',
      viewThisRepo: true,
    );

    setState(() => isLoadingThisCommits = false);

    if (response.isSuccessful) {
      // Provider.of<AppStateManager>(context, listen: false).login();

    } else {
      showPlatformDialog(
          context: context,
          builder: (_) => PlatformAlertDialog(
            title: Text(
              'Oops, something unexpected happened, please try again later.',
              style: GoogleFonts.nunitoSans(
                textStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              textAlign: TextAlign.center,
            ),
            actions: [
              PlatformTextButton(
                child: Text('Ok', style: GoogleFonts.nunitoSans(
                  textStyle: const TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 15,
                  ),
                )),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          )
      );
    }
  }

  void _submitForm(context) async {
    if (_formValidator.currentState!.validate()) {
      setState(() => isLoadingOtherCommits = true);

      Response response = await AuthServices().login(
        token: _controllerToken.text,
        viewThisRepo: false,
      );

      setState(() => isLoadingOtherCommits = false);

      if (response.isSuccessful) {
        Provider.of<AppStateManager>(context, listen: false).login();
      } else {
        showPlatformDialog(
            context: context,
            builder: (_) => PlatformAlertDialog(
              title: Text(
                'Oops! ❌ \n The token seems to be invalid. \n\nPlease try again.',
                style: GoogleFonts.nunitoSans(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
              content: SizedBox(
                height: 120,
                width: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error,
                      color: Colors.red,
                      size: 50,
                    ),
                    Text(
                      'If you don\'t know how to get a personal access token, click on the link in the form.',
                      style: GoogleFonts.nunitoSans(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              actions: [
                PlatformTextButton(
                  child: Text('Ok', style: GoogleFonts.nunitoSans(
                    textStyle: const TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 15,
                    ),
                  )),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            )
        );
      }
    }
  }
}
