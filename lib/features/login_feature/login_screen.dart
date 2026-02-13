import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../app/core/utils/shared/app_elevated_button.dart';
import '../../app/core/utils/shared/app_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
            "Welcome Back",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          // Image
          // Spacer(),
          Center(child: Image.asset('assets/back_to_school.png')),
          Spacer(),

          // Forms
          AppTextFormField(hintText: "Enter your Email"),
          AppTextFormField(hintText: "Enter your Password"),

          // Forget Password
          Spacer(),
          TextButton(
            onPressed: () {
              print("forget password Pressed");
            },
            child: Text(
              "Forget Password?",
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                color: Color(0xDD50C2C9),
              ),
            ),
          ),
          Spacer(),

          // Login Button
          AppElevatedButton(text: "Login"),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account?"),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Sign Up",
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
