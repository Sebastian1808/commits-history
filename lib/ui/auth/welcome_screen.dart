import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';

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
                          CustomButton(onPressed: (){}, textButton: 'View Commits For This Repo',)
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
                                "You don't know how to get a \npersonal access token?",
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
                                onPressed: ()=> {print('HOLI')}
                            )
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        CustomButton(
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

  void _submitForm(context) async {
    if (_formValidator.currentState!.validate()) {
      // TODO: Implement the logic to Auth with the token

    }
  }
}
