import 'dart:convert';

import 'package:commits_history/api/extensions.dart';
import 'package:commits_history/ui/auth/components/card_commits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../api/auth/auth_services.dart';
import '../manager/app_state_manager.dart';
import '../theme/style.dart';
import 'auth/components/custom_app_bar_menu.dart';
import 'auth/components/custom_card_wrapper.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late Future<List<dynamic>> _projectsCommits;
  late bool isDefaultProjectSelected;

  late String projectName;
  late String projectOwner;

  @override
  void initState() {
    isDefaultProjectSelected = context.read<AppStateManager>().isDefaultProject;

    projectName = context.read<AppStateManager>().projectName ?? '';
    projectOwner = context.read<AppStateManager>().projectOwner ?? '';

    _projectsCommits = getProjectCommits(
        projectName,
        projectOwner
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: customAppBarMenu('Commits History', isDefaultProjectSelected, context),
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
                      'Commit History Of: \n $projectName/$projectOwner',
                      style: GoogleFonts.nunito(
                        textStyle: Styles.headline3,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  FutureBuilder(
                      future: _projectsCommits,
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
                                  child: CardCommits(
                                        commits: snapshot.data!
                                    ),
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

  Future<List<dynamic>> getProjectCommits(String repoName, String repoOwner) async {
    Response response = await AuthServices().getHistoryCommits(
        repoName: repoName,
        repoOwner: repoOwner,
    );

    if (response.isSuccessful) {
      List<dynamic> commits = jsonDecode(response.body);

      return commits;

    } else {
      return [];
    }
  }
}
