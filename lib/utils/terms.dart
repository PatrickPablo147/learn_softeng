import 'package:flutter/material.dart';
import 'package:software_engineering/utils/reusableText.dart';

import '../const/colors.dart';

class TermsAndCondition extends StatelessWidget {
  const TermsAndCondition({Key? key}) : super(key: key);

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
          child: Center(child: reusableTitleText("TermsAndCondition", textColor)),
        )
      ],
    );
  }
}
