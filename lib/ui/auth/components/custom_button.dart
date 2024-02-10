import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends StatelessWidget {
  final Function onPressed;
  final String textButton;
  const CustomButton({
    required this.onPressed,
    required this.textButton,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PlatformElevatedButton(
          onPressed: () => onPressed(),
          material: (_,__) => MaterialElevatedButtonData(
            child: SizedBox(
                width: double.infinity,
                child: Text(textButton,
                  style: GoogleFonts.nunito(
                    color: Colors.grey[100],
                    fontSize: 15,
                    fontWeight: FontWeight.w700,

                  ),
                  textAlign: TextAlign.center,
                )
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(15.0),
              backgroundColor: Colors.blueGrey,
            ),
          ),

          cupertino: (_,__) => CupertinoElevatedButtonData(
            child: SizedBox(
                width: double.infinity,
                child: Text(textButton,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.black)
                )
            ),
            originalStyle: true,
            color: const Color.fromRGBO(249, 190, 34, 1),
            padding: const EdgeInsets.all(15.0),
          ),
        )
      ],
    );
  }
}
