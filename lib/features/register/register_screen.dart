import 'package:app_example/core/utils/app_elevated_button.dart';
import 'package:app_example/core/utils/app_text_form_field.dart';
import 'package:app_example/features/register/register_logic.dart'; // Import the logic file
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Create an instance of your logic class
  final _registerLogic = RegisterLogic();

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    // Send the data to your logic file
    final errorMessage = await _registerLogic.registerUser(
      fullName: _fullNameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
      confirmPassword: _confirmPasswordController.text,
    );

    if (!mounted) return;

    // Handle the result sent back from register_logic.dart
    if (errorMessage == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Registration Successful!')));
      Navigator.pop(context); // Go back to login
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(errorMessage)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        spacing: 20,
        children: [
          Align(
            alignment: Alignment.topLeft,
            // child: Image.asset('assets/shape.png'),
          ),
          Text(
            "Welcome to Onboard",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),

          Spacer(),
          AppTextFormField(
            hintText: "Enter your Fullname",
            controller: _fullNameController,
          ),
          AppTextFormField(
            hintText: "Enter your Email",
            controller: _emailController,
          ),
          AppTextFormField(
            hintText: "Enter Password",
            controller: _passwordController,
            // obscureText: true,
          ),
          AppTextFormField(
            hintText: "Confirm Password",
            controller: _confirmPasswordController,
            // obscureText: true,
          ),
          Spacer(),

          // Use the new _handleRegister method here
          AppElevatedButton(text: "Register", onPressed: _handleRegister),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have an account?"),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
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
