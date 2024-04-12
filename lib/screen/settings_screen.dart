import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:software_engineering/const/colors.dart';
import 'package:software_engineering/screen/about.dart';
import 'package:software_engineering/screen/clear_record.dart';
import 'package:software_engineering/services/auth_service.dart';
import 'package:software_engineering/utils/reusableText.dart';
import 'package:software_engineering/utils/terms.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final AuthService authService = AuthService();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Navigation
              _navigation(context, authService),
            ],
          ),
        )
      ),
    );
  }

  _navigation(BuildContext context, AuthService authService) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        reusableText(FirebaseAuth.instance.currentUser?.displayName.toString() ?? 'NO USERS', Colors.black),
        const Divider(
          thickness: 1,
          color: Colors.grey,
        ),
        TextButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ClearRecord())
          ),
          child: reusableSubtitleText(
            "Clear Records",
            textColor
          ),
        ),
        const SizedBox(height: 8),
        const Divider(
          thickness: 1,
          color: Colors.grey,
        ),
        TextButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const About())
          ),
          child: reusableSubtitleText(
              "About",
              textColor
          ),
        ),
        const Divider(
          thickness: 1,
          color: Colors.grey,
        ),
        TextButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TermsAndCondition())
          ),
          child: reusableSubtitleText(
              "Terms and Condition",
              textColor
          ),
        ),
        const Divider(
          thickness: 1,
          color: Colors.grey,
        ),
        TextButton(
          onPressed: () {
            authService.signOut();
          },
          child: reusableSubtitleText(
              "Log out",
              textColor
          ),
        ),
      ],
    );
  }
}
