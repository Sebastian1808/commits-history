import 'dart:convert';

import 'package:commits_history/api/auth/auth_services.dart';
import 'package:commits_history/api/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../../manager/app_state_manager.dart';
import '../../theme/style.dart';
import '../components/card_projects.dart';
import '../components/custom_card_wrapper.dart';

class SelectProjectScreen extends StatefulWidget {
  const SelectProjectScreen({super.key});

  @override
  State<SelectProjectScreen> createState() => _SelectProjectScreenState();
}

class _SelectProjectScreenState extends State<SelectProjectScreen> {
  late Future<List<dynamic>> _userProjects;

  @override
  void initState() {
    _userProjects = getUserProjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        material: (_, __) =>
            MaterialAppBarData(
              centerTitle: true,
            ),
        trailingActions: [
          PlatformIconButton(
            onPressed: () async {
              await context.read<AppStateManager>().logout();
              if(!context.mounted) return;
              context.goNamed('welcome');
            },
            icon: const FaIcon(
              FontAwesomeIcons.arrowRightFromBracket,
              color: Colors.amber,
              size: 20.0,
            ),
          ),
        ],
        title: Text(
          'Select a project',
          style: GoogleFonts.nunito(
              textStyle: Styles.headline2,
              color: Colors.white
          ),
        ),
        backgroundColor: Colors.grey[850],
      ),
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
                    child: Text(
                      'Here you have a list of projects associated to your account, '
                          'please select the repository you want to see the commit history for . ',
                      style: GoogleFonts.nunito(
                        textStyle: Styles.headline3,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  FutureBuilder(
                      future: _userProjects,
                      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return const Center(
                              child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.blueGrey)
                              ),
                            );
                          default:
                            if (!snapshot.hasError) {
                              if (snapshot.data!.isNotEmpty) {
                                return Expanded(
                                    child: CardProjects(
                                        projects: snapshot.data!
                                    )
                                );
                              } else {
                                return CustomCardWrapper(
                                  child: Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                            Icons.drafts,
                                            color: Colors.amber,
                                            size: 80
                                        ),
                                        const SizedBox(height: 20),
                                        Text(
                                          "It looks like you still don't have any project ",
                                          style: GoogleFonts.nunitoSans(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            } else {
                              return CustomCardWrapper(
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(
                                          Icons.web_asset_off_rounded,
                                          color: Colors.red,
                                          size: 70
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        'Sorry, an error occurred while loading the data.\n\n'
                                            'Please try again later.',
                                        style: GoogleFonts.nunitoSans(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                        }
                      }
                  ),
                  Image.asset('assets/logos/login_decoration.png'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<List<dynamic>> getUserProjects() async {
    Response response = await AuthServices().getUserProjects();

    if (response.isSuccessful) {
      List<dynamic> projects = jsonDecode(response.body);
      return projects;

    } else {
      return [];
    }
  }
}