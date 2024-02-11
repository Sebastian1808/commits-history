import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../manager/app_state_manager.dart';
import '../../../theme/style.dart';
import 'custom_card_wrapper.dart';

class CardProjects extends StatelessWidget {
  final List<dynamic> projects;

  const CardProjects({super.key, required this.projects});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: projects.length,
        itemBuilder: (context, i) {
          return GestureDetector(
            onTap: () async {
              if(!context.mounted) return;
              // Set the selected project
              context.read<AppStateManager>().selectProject(
                  projects[i]['name'],
                  projects[i]['owner']['login']
              );
            },
            child: CustomCardWrapper(
              child:  Padding(
                padding: const EdgeInsets.all(5.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.folder_open, color: Colors.indigo, size: 30),
                      Text(
                        projects[i]['name'],
                        style: GoogleFonts.nunitoSans(
                            textStyle: Styles.bodyText1
                        ),
                        textAlign: TextAlign.center,
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