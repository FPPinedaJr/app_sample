import 'package:app_example/core/widgets/app_elevated_button.dart';
import 'package:app_example/core/widgets/app_text_form_field.dart';
import 'package:app_example/features/login/login_logic.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _loginLogic = LoginLogic();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    final errorMessage = await _loginLogic.loginUser(
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );

    if (!mounted) return;

    if (errorMessage == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Login Successful!')));

      // Navigator.pushReplacementNamed(context, '/home');
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
            "Welcome Back",
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Center(
            // child: Image.asset('assets/back_to_school.png')
          ),
          Spacer(),
          AppTextFormField(
            hintText: "Enter your Email",
            controller: _emailController,
          ),
          AppTextFormField(
            hintText: "Enter your Password",
            controller: _passwordController,
            // obscureText: true,
          ),
          Spacer(),
          TextButton(
            onPressed: () {},
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
          AppElevatedButton(text: "Login", onPressed: _handleLogin),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have an account?"),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
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
