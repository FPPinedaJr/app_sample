import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


// move elevated button class here then call it to view


class AppElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const AppElevatedButton({super.key, this.onPressed, required this.text});

  ButtonStyle get buttonStyle => ButtonStyle(
    backgroundColor: WidgetStateProperty.all(Color(0xDD50C2C9)),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 360,
      child: ElevatedButton(
        onPressed: onPressed,
        style: buttonStyle,
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
