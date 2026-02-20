import 'package:app_example/core/utils/app_elevated_button.dart';
import 'package:app_example/core/utils/app_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        spacing: 20,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Image.asset('assets/shape.png'),
          ),
          Text(
            "Welcome to Onboard",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Image

          // Forms
          Spacer(),
          AppTextFormField(hintText: "Enter your Fullname"),
          AppTextFormField(hintText: "Enter your Email"),
          AppTextFormField(hintText: "Enter Password"),
          AppTextFormField(hintText: "Confirm Passoword"),
          Spacer(),

          // Register Button
          AppElevatedButton(text: "Register"),

          // already have an account
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have an account?"),
              TextButton(
                onPressed: () {
                  Navigator.pop(context, '/register');
                },
                child: Text(
                  "Sign In",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    color: Color(0xDD50C2C9),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
