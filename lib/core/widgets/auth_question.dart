import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthQuestion extends StatelessWidget {
  final String title;
  final String actionText;
  final VoidCallback onPressed;

  const AuthQuestion({
    super.key,
    required this.title,
    required this.actionText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(title),
        TextButton(
          onPressed: onPressed,
          child: Text(
            actionText,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w300,
              color: const Color(0xDD50C2C9),
            ),
          ),
        ),
      ],
    );
  }
}
