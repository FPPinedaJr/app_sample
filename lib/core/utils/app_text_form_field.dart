import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// move text form class here then call it to view

class AppTextFormField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;

  const AppTextFormField({super.key, this.controller, this.hintText});

  InputBorder get inputBorder => OutlineInputBorder(
    borderRadius: BorderRadius.circular(100),
    borderSide: BorderSide(color: Colors.white),
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 360,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w200,
            color: Colors.black,
          ),
          focusColor: Colors.white,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: inputBorder,
          focusedBorder: inputBorder,
          border: inputBorder,
        ),
      ),
    );
  }
}
