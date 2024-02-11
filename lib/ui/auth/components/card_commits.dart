import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/style.dart';
import 'custom_card_wrapper.dart';

class CardCommits extends StatelessWidget {
  final List<dynamic> commits;

  const CardCommits({super.key, required this.commits});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: commits.length,
        itemBuilder: (context, i) {
          return GestureDetector(
            onTap: () async {
              // TODO: Show Full Commit
            },
            child: CustomCardWrapper(
              child:  Padding(
                padding: const EdgeInsets.all(5.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(Icons.folder_open, color: Colors.indigo, size: 30),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Text(
                          commits[i]['commit']["message"],
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: GoogleFonts.nunitoSans(
                              textStyle: Styles.bodyText1
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded, color: Colors.green, size: 30),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
    );
  }
}