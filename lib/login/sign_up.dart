import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:software_engineering/login/sign_in.dart';
import 'package:software_engineering/services/auth_service.dart';
import '../const/colors.dart';
import '../controller/bottom_nav_bar.dart';
import '../utils/reusableText.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 80,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: reusableTitleText('Create your Account', Colors.black),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: reusableText('Register below your details!', Colors.black),
              ),
              const SizedBox(height: 30,),
          
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36.0),
                child: reusableSubtitleText('Username', Colors.black),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                child: TextField(
                  controller: usernameController,
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
                      hintText: 'Username',
                      hintStyle: GoogleFonts.inter(
                          color: Colors.grey,
                          fontSize: 16
                      )
                  ),
                ),
              ),
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36.0),
                child: reusableSubtitleText('Confirm Password', Colors.black),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
                child: TextField(
                  obscureText: true,
                  controller: confirmPassController,
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
                      hintText: 'Confirm Password',
                      hintStyle: GoogleFonts.inter(
                          color: Colors.grey,
                          fontSize: 16
                      )
                  ),
                ),
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
                        String userName = usernameController.text.trim();
                        String email = emailController.text.trim();
                        String password = passwordController.text.trim();

                        _authService.createUserWithEmailPassword(email, password, userName);


                        Navigator.push(context, MaterialPageRoute(builder: (context) => const MyBottomNavBar()));
          
                        usernameController.clear();
                        emailController.clear();
                        passwordController.clear();
                        confirmPassController.clear();
                      },
                      child: reusableText('Sign Up', Colors.white)
                  ),
                ),
              ),
          
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  reusableText('Already have account? ', Colors.black),
                  GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SignInScreen())),
                      child: reusableText('Sign In', Colors.blueAccent)
                  )
                ],
              )
            ],
          ),
        )
      ),
    );
  }
}
