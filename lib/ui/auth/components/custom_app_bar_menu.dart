import 'package:commits_history/manager/app_state_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

PlatformAppBar customAppBarMenu(String title, bool isDefaultProject, context) {
  return PlatformAppBar(
    material: (_, __) => MaterialAppBarData(
      centerTitle: true,
    ),
    title: Text(
      title,
      style: GoogleFonts.nunitoSans(
          textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold
          )
      ),
    ),
    leading: PlatformWidget(
      material: (_, __) => IconButton(
        icon: const Icon(Icons.menu, color: Colors.white),
        onPressed: () {
          showPopup(context, isDefaultProject);
        },
      ),
      cupertino: (_, __) => CupertinoButton(
        child: const Icon(CupertinoIcons.bars, color: Colors.white),
        onPressed: () {
          showPopup(context, isDefaultProject);
        },
      ),
    ),
    cupertino: (_, __) => CupertinoNavigationBarData(
      backgroundColor: CupertinoColors.black,
    ),
  );

}

void showPopup(context, bool isDefaultProject) {
  showCupertinoModalPopup(
      context: context,
      builder: (BuildContext builder) {
        return CupertinoPopupSurface(
          isSurfacePainted: true,
          child: Container(
              padding: const EdgeInsetsDirectional.all(20),
              color: CupertinoColors.white,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              height: isDefaultProject
                  ? MediaQuery.of(context).copyWith().size.height * 0.11
                  : MediaQuery.of(context).copyWith().size.height * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  isDefaultProject
                    ? const SizedBox()
                    : GestureDetector(
                    onTap: () => changeProject(context),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(CupertinoIcons.folder_open,
                            color: Colors.blueGrey),
                        PlatformTextButton(
                          onPressed: () => changeProject(context),
                          child: const Text(
                            'Change Repository',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios, color: Colors.blueGrey),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Provider.of<AppStateManager>(context, listen: false).logout(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const FaIcon(
                          FontAwesomeIcons.arrowRightFromBracket,
                          color: Colors.blueGrey,
                          size: 20.0,
                        ),
                        PlatformTextButton(
                          onPressed: () => Provider.of<AppStateManager>(context, listen: false).logout(),
                          child: const Text(
                            'Logout',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const Icon(Icons.arrow_forward_ios, color: Colors.blueGrey),
                      ],
                    ),
                  ),
                ],
              )
          ),
        );
      }
  );
}

void changeProject(context) {
  if (Provider.of<AppStateManager>(context, listen: false).canResetProject()){
    GoRouter.of(context).goNamed('selectProject');
  }
}

