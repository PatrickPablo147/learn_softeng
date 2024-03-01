import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering/utils/reusableText.dart';
import '../const/colors.dart';
import '../controller/bottom_nav_bar.dart';
import '../database/data_manager.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  String? status;
  bool isAgree = false;

  void _start(DataManager value, String status) {
    if(isAgree && status.isNotEmpty) {
      value.updateUsername(status);

      Navigator.of(context).push(_createRoute());
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: reusableText('Please agree to the terms and condition', Colors.white)
        ),
      );
    }
  }

  void _showDialog(String title) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: reusableSubtitleText(title, textColor),
        content: SizedBox(
          height: 300,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                reusableSubtitleText(
                  "\n1. Acceptance of Terms",
                  textColor
                ),
                reusableText(
                  "\nBy using Learn SoftEng, you agree to comply with and be bound by the following terms and conditions of use. If you do not agree to these terms, please do not use the Application.",
                  textColor
                ),
                reusableSubtitleText(
                  "\n2. License",
                  textColor
                ),
                reusableText("\nSubject to your compliance with these Terms, our team grants you a limited, non-exclusive, non-transferable, revocable license to use the App for your personal, non-commercial purposes.", textColor),
                reusableSubtitleText(
                  "\n3. User Registration",
                  textColor
                ),
                reusableText(
                  "\nIn order to access certain features of the App, you may be required to register for an account. You agree to provide accurate, current, and complete information during the registration process and to update such information to keep it accurate, current, and complete.",
                  textColor
                ),
                reusableSubtitleText(
                  "\n4. Code of Conduct",
                  textColor
                ),
                reusableText(
                  "\nYou agree not to engage in any of the following activities:"
                  "\n•	Violating any applicable laws or regulations."
                  "\n•	Transmitting any material that is unlawful, harmful, defamatory, obscene, or otherwise objectionable."
                  "\n•	Attempting to interfere with the proper functioning of the App."
                  "\n•	Using the App to infringe upon the intellectual property rights of others.",
                  textColor
                ),
                reusableSubtitleText(
                  "\n5. Intellectual Property",
                  textColor
                ),
                reusableText(
                    "\nAll content included in the App, including but not limited to text, graphics, logos, and images, is the property of ECC BSCS – IV Group 3 Students (SY) 2023 - 2024 or its licensors and is protected by copyright and other laws.",
                    textColor
                ),
                reusableSubtitleText(
                  "\n6. Privacy",
                  textColor
                ),
                reusableText(
                  "\nYour data will be collected and process as the outlined in our Privacy Policy. By using LearnSoftEng, your consent to the storage, collecting, and processing of persona data in accordance with our Privacy Policy ",
                  textColor
                ),
                reusableSubtitleText(
                  "\n7. Termination",
                  textColor
                ),
                reusableText(
                  "\nECC BSCS – IV Group 3 Students (SY) 2023 – 2024 reserves the right to terminate or suspend your access to the App at any time, without notice, for conduct that we believe violates these Terms or is harmful to other users of the App or third parties.",
                  textColor
                ),
                reusableSubtitleText(
                  "\n8. Disclaimer of Warranties",
                  textColor
                ),
                reusableText(
                  "\nThe App is provided \"as is\" and \"as available\" without any warranties, express or implied.",
                  textColor
                ),
                reusableSubtitleText(
                  "\n9. Limitation of Liability",
                  textColor
                ),
                reusableText(
                  "\nTo the fullest extent permitted by applicable law, ECC BSCS – IV Group 3 Students (SY) 2023 - 2024 shall not be liable for any indirect, incidental, special, consequential, or punitive damages, or any loss of profits or revenues.",
                  textColor
                ),
                reusableSubtitleText(
                  "\n10. Changes to Terms",
                  textColor
                ),
                reusableText(
                  "\nECC BSCS – IV Group 3 Students (SY) 2023 – 2024 reserves the right to change these Terms at any time. Updated versions of the Terms will be posted on the App. Your continued use of the App after any such changes constitutes your acceptance of the new Terms.",
                  textColor
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                isAgree = true;
                Navigator.pop(context);
              });
            },
            child: reusableText('Agree', textColor),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<DataManager>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 50.0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 90),
                      height: 340,
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.8),
                        shape: BoxShape.circle
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 32),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'WELCOME TO',
                                style: GoogleFonts.inter(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'LEARN SOFTENG',
                                style: GoogleFonts.inter(
                                  fontSize: 34,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20,),
                        SizedBox(
                          height: 400, width: 400,
                          child: Image.asset('lib/assets/softEng1.png',),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              value: isAgree,
                              onChanged: (value){
                                setState(() {
                                  isAgree = !isAgree;
                                });
                              },
                              side: const BorderSide(color: primaryColor, width: 2),
                            ),
                            GestureDetector(
                              onTap: () => _showDialog(
                                'User\'s Agreement',
                              ),
                              child: Text(
                                'I agree to the terms and condition',
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: textColor,
                                  decoration: TextDecoration.underline
                                ),
                              )
                            )
                          ],
                        ),

                        const SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const SizedBox(width: 40,),
                            Expanded(
                              child: RadioListTile(title: const Text('student'), value: 'student', groupValue: status, onChanged: (value) {
                                setState(() {
                                  print(value);
                                  status = value.toString();
                                });
                              }),
                            ),
                            Expanded(
                              child: RadioListTile(title: const Text('teacher'), value: 'teacher', groupValue: status, onChanged: (value) {
                                setState(() {
                                  print(value);
                                  status = value.toString();
                                });
                              }),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20,),

                        Center(
                          child: MaterialButton(
                            onPressed: () => _start(value, status!),
                            minWidth: 300,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            color: primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8), // Set your desired border radius
                            ),
                            splashColor: Colors.grey.withOpacity(0.5),
                            highlightColor: const Color(0xFF80B2FE).withOpacity(0.2),
                            child: reusableTitleText('Start', Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
        ),
      ),
    );
  }

  Route _createRoute() {
    const duration = Duration(seconds: 1); // Adjust the duration as needed

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const MyBottomNavBar(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.0;
        const end = 1.0;

        var fadeAnimation = Tween(begin: begin, end: end).animate(
          CurvedAnimation(parent: animation, curve: Curves.easeInOut), // Use any curve you prefer
        );

        return Stack(
          children: [
            // Your background
            Container(
              color: Colors.black, // Set your dark background color
            ),
            // Fading content
            FadeTransition(
              opacity: fadeAnimation,
              child: child,
            ),
          ],
        );
      },
      transitionDuration: duration,
    );
  }
}
