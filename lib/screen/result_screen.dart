import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:software_engineering/const/colors.dart';
import 'package:software_engineering/screen/home_screen.dart';
import 'package:software_engineering/screen/quiz_runtime_screen.dart';
import 'package:software_engineering/utils/reusableText.dart';

/* PATTY DEV
* Summary:
* This handles the Result display screen after completion of QUIZ
* - Text Message
* - Quiz Percent
* - Navigation --> next quiz, retrying again, view of other quiz, learning new topics
* */

class ResultScreen extends StatelessWidget {
  final int selectedQuiz;
  final int courseIndex;
  final int score;
  final int total;
  const ResultScreen({Key? key, required this.score, required this.total, required this.selectedQuiz, required this.courseIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Result View Container
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
                  boxShadow: [
                    BoxShadow(
                      color: shadowColor,
                      blurRadius: 15,
                      spreadRadius: 2,
                      offset: Offset(0, 4)
                    )
                  ]
                ),
                child: resultContainer()
              ),
              const SizedBox(height: 16,),

              // Items Value -> Correct - Wrong - Total
              itemValue(),
              const SizedBox(height: 24,),

              // Action Button
              actionButton(context)
            ],
          ),
        ),
      ),
    );
  }

  resultContainer() {
    double percentString = (score / total * 100).toDouble();
    double percentInt = (score / total * 100 / 100).toDouble();
    String formattedPercent = percentString.toStringAsFixed(0);
    return Padding(
      padding: const EdgeInsets.only(top: 42.0, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          reusableTitleText('You have completed the test!', textColor),
          const SizedBox(height: 8,),

          reusableText('here\'s your result', textColor),
          const SizedBox(height: 32,),

          Stack(
            alignment: Alignment.center,
            children: [
              CircularPercentIndicator(
                radius: 60,
                lineWidth: 20,
                percent: percentInt,
                progressColor: primaryColor,
                backgroundColor: primaryColor.withOpacity(0.5),
                animation: true,
                animationDuration: 2000,
              ),
              Text('$formattedPercent%')
            ],
          ),

          const SizedBox(height: 24,),

          reusableText(textMessage(), textColor)
        ],
      ),
    );
  }

  String textMessage() {
    String message = "";
    if(score > total/1.5) {
      message = "You've done an excellent job";
    }
    else if(score > total/2) {
      message = "You passed the quiz";
    }
    else {
      message = "You failed the quiz";
    }
    return message;
  }

  itemValue() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            reusableText('Correct', green),
            const SizedBox(height: 4,),
            Row(
              children: [
                Container(
                  width: 8, height: 8,
                  decoration: const BoxDecoration(
                      color: green,
                      shape: BoxShape.circle
                  ),
                ),
                const SizedBox(width: 8,),
                reusableText(score.toString(), textColor)
              ],
            ),
          ],
        ),
        Column(
          children: [
            reusableText('Wrong', red),
            Row(
              children: [
                Container(
                  width: 8, height: 8,
                  decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle
                  ),
                ),
                const SizedBox(width: 8,),
                reusableText((total - score).toString(), textColor)
              ],
            ),
          ],
        ),
        Column(
          children: [
            reusableText('Total', textColor),
            Row(
              children: [
                Container(
                  width: 8, height: 8,
                  decoration: const BoxDecoration(
                      color: textColor,
                      shape: BoxShape.circle
                  ),
                ),
                const SizedBox(width: 8,),
                reusableText(total.toString(), textColor)
              ],
            ),
          ],
        )
      ],
    );
  }

  actionButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          MaterialButton(
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => QuizRuntimeScreen(courseIndex: courseIndex, selectedQuiz: selectedQuiz + 1, key: UniqueKey(),))),
            padding: const EdgeInsets.all(24),
            minWidth: double.infinity,
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Set your desired border radius
            ),
            child: Row(
              children: [
                const SizedBox(
                    height: 20, width: 20,
                    child: Image(image: AssetImage("lib/assets/next.png"))
                ),
                const SizedBox(width: 24,),
                reusableText(
                    'Next Quiz',
                    textColor
                ),
              ],
            ),
          ),
          const SizedBox(height: 12,),
          MaterialButton(
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => QuizRuntimeScreen(courseIndex: courseIndex, selectedQuiz: selectedQuiz, key: UniqueKey(),))),
            padding: const EdgeInsets.all(24),
            minWidth: double.infinity,
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Set your desired border radius
            ),
            child: SizedBox(
              width: double.infinity,
              child: Row(
                children: [
                  const SizedBox(
                      height: 20, width: 20,
                      child: Image(image: AssetImage("lib/assets/retry.png"))
                  ),
                  const SizedBox(width: 24,),
                  reusableText(
                      'Try Again',
                      textColor
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12,),
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            padding: const EdgeInsets.all(24),
            minWidth: double.infinity,
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12), // Set your desired border radius
            ),
            child: Row(
              children: [
                const SizedBox(
                    height: 20, width: 20,
                    child: Image(image: AssetImage("lib/assets/view.png"))
                ),
                const SizedBox(width: 24,),
                reusableText(
                    'Try Other Quiz',
                    textColor
                ),
              ],
            ),
          ),
          const SizedBox(height: 12,),
          MaterialButton(
            onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomeScreen())),
            padding: const EdgeInsets.all(24),
            minWidth: double.infinity,
            color: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                const SizedBox(
                    height: 20, width: 20,
                    child: Image(image: AssetImage("lib/assets/learn.png"))
                ),
                const SizedBox(width: 24,),
                reusableText(
                    'Learn More',
                    textColor
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
