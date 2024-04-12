import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:software_engineering/login/sign_up.dart';
import 'package:software_engineering/services/auth_service.dart';
import 'package:software_engineering/services/firestore_service.dart';

import '../const/colors.dart';
import '../utils/reusableText.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final AuthService _authService = AuthService();

  @override void dispose() {
    // TODO: implement dispose
    super.dispose();

    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60,),

              Center(child: Image.asset('lib/assets/icon.jpg', width: 200, height: 200,)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: reusableTitleText('Login to your Account', Colors.black),
              ),

              const SizedBox(height: 30,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36.0),
                child: reusableSubtitleText('Email', Colors.black),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                child: TextField(
                  controller: emailController,
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: lGrey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: lGrey),
                    ),
                    hintText: 'Email',
                    hintStyle: GoogleFonts.inter(
                      color: Colors.grey,
                      fontSize: 16
                    )
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36.0),
                child: reusableSubtitleText('Password', Colors.black),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                child: TextField(
                  obscureText: true,
                  controller: passwordController,
                  style: GoogleFonts.inter(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: lGrey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: lGrey),
                      ),
                      hintText: 'Password',
                      hintStyle: GoogleFonts.inter(
                          color: Colors.grey,
                          fontSize: 16
                      )
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 25,),
                  reusableText('Forgot Password?', Colors.black),
                ],
              ),

              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 12),
                  child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      height: 60,
                      elevation: 0,
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // Set your desired border radius
                      ),
                      onPressed: () {
                        String email = emailController.text.trim();
                        String password = passwordController.text.trim();

                        _authService.signInWithEmailAndPassword(email, password);

                        emailController.clear();
                        passwordController.clear();

                      },
                      child: reusableText('Log In', Colors.white)
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  reusableText('Not registered yet? ', Colors.black),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpScreen())),
                    child: reusableText('Create account', Colors.blueAccent)
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
