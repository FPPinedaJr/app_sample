import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
