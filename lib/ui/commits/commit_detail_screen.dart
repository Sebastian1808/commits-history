import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../manager/app_state_manager.dart';
import '../../theme/style.dart';
import 'package:intl/intl.dart';

import '../components/custom_app_bar_back_button.dart';
import '../components/custom_card_wrapper.dart';

class CommitDetailScreen extends StatefulWidget {
  final Map<String, dynamic> commit;
  const CommitDetailScreen({
    super.key,
    required this.commit
    });

  @override
  State<CommitDetailScreen> createState() => _CommitDetailScreenState();
}

class _CommitDetailScreenState extends State<CommitDetailScreen> {
  late String projectName;
  late String projectOwner;

  @override
  void initState() {
    projectName = context.read<AppStateManager>().projectName ?? '';
    projectOwner = context.read<AppStateManager>().projectOwner ?? '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: customAppBarBackButton('Detail Commit', context),
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
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.88,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomCardWrapper(
                  child: Text(
                    '📖 $projectName/$projectOwner',
                    style: GoogleFonts.nunito(
                      textStyle: Styles.headline3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: CustomCardWrapper(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Commit',
                              style: GoogleFonts.nunito(
                                  textStyle: Styles.bodyTextBoldJumbo,
                                  color: Colors.blueGrey
                              ),
                              textAlign: TextAlign.start,
                            ),
                            const SizedBox(height: 20.0),
                            Text(
                              widget.commit['commit']['message'],
                              style: GoogleFonts.nunito(
                                  textStyle: Styles.bodyText1,
                                  fontStyle: FontStyle.italic
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Author',
                                  style: GoogleFonts.nunito(
                                    textStyle: Styles.bodyTextBoldJumbo,
                                    color: Colors.amber,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  widget.commit['commit']['author']['name'],
                                  style: GoogleFonts.nunito(
                                    textStyle: Styles.bodyText1,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Date',
                                  style: GoogleFonts.nunito(
                                    textStyle: Styles.bodyTextBoldJumbo,
                                    color: Colors.green,
                                  ),
                                  textAlign: TextAlign.start,
                                ),
                                Text(
                                  dateFormat(widget.commit['commit']['author']['date']),
                                  style: GoogleFonts.nunito(
                                    textStyle: Styles.bodyText1,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Image.asset('assets/logos/login_decoration.png'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

String dateFormat(String date) {
  DateTime dateFormatted = DateTime.parse(date);

  return DateFormat('dd MMMM yyyy').format(dateFormatted).toString();
}