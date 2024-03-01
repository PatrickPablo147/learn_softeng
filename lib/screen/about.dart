import 'package:flutter/material.dart';
import 'package:software_engineering/utils/reusableText.dart';
import '../const/colors.dart';

class About extends StatelessWidget {
  const About({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
            child:SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _header(context),
                  const SizedBox(height: 32,),
                  reusableSubtitleText('About Learn SoftEng', textColor),
                  reusableText('\nWelcome to Learn SoftEng, a mobile application created by a passionate group of BSCS students, known as Group 3 batch 2023-2024. We are driven by our shared enthusiasm for software engineering and our commitment to making complex concepts in the field more accessible to fellow learners, professionals, and enthusiasts.', textColor),
                  const SizedBox(height: 24,),
                  reusableSubtitleText('Our Mission', textColor),
                  reusableText('\nOur mission is to provide a platform where individuals can engage with high-quality content, resources, and discussions related to software engineering. We aim to foster a community of continuous learning, collaboration, and innovation in the ever-evolving world of technology.', textColor),
                  const SizedBox(height: 24,),
                  reusableSubtitleText('Who We Are', textColor),
                  reusableText('\nGroup 3 BSCS Students', textColor),
                  reusableText('We are a dynamic group of BSCS students dedicated to combining our diverse skills and knowledge to create a valuable resource for the software engineering community. Our backgrounds vary from programming and algorithm design to user experience and interface development.', textColor),
                  const SizedBox(height: 24,),
                  reusableSubtitleText('Meet the team', textColor),
                  reusableText('Name: Arojado, Jhayross O. \nRole: Content Creator', textColor),
                  reusableText('Name: Delos Reyes, Paul Justine, O. \nRole: Developer', textColor),
                  reusableText('Role: Barcelon, Marie Neilly L.\nRole: UX/UI Designer', textColor),
                  reusableText('Name: Arevalo, Joven D. \nRole: Lead Developer', textColor)
                ],
              ),
            ),
          )
      ),
    );
  }

  _header(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        MaterialButton(
          onPressed: () => Navigator.pop(context),
          color: primaryColor,
          height: 46, minWidth: 50,
          padding: const EdgeInsets.only(right: 4),
          shape: const CircleBorder(),
          splashColor: Colors.white.withOpacity(0.2),
          highlightColor: Colors.white.withOpacity(0.2),
          child: const Icon(Icons.arrow_back_ios_new_outlined, color: Colors.white,),
        ),
        Expanded(
          child: Center(child: reusableTitleText("About", textColor)),
        )
      ],
    );
  }
}
