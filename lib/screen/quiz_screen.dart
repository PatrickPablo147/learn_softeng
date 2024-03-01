import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering/const/colors.dart';
import 'package:software_engineering/screen/add_new_quiz.dart';
import 'package:software_engineering/screen/quiz_runtime_screen.dart';
import 'package:software_engineering/utils/reusableText.dart';
import '../database/data_manager.dart';

/* PATTY DEV
* Summary:
* Quiz Screen --> Widget that handle the quiz selection and quiz run time and instruction
* - Display all available quiz e.g Software Engineering 1 Quiz, Software Engineering 2 Quiz, Custom Quiz
* */
class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DataManager>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 24, left: 12, right: 12, bottom: 12),
            child: Column(
              children: [
                //header
                _header(value),
                const SizedBox(height: 20,),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 12),
                        //Software Engineering 1 --> Quiz
                        reusableSubtitleText("Software Engineering 1", textColor),
                        const SizedBox(height: 12,),
                        _quizOption(value, 0),

                        const SizedBox(height: 24,),

                        // Software Engineering 2 --> Quiz
                        reusableSubtitleText("Software Engineering 2", textColor),
                        const SizedBox(height: 12,),
                        _quizOption(value, 1),

                        const SizedBox(height: 24,),

                        // Custom Quiz
                        reusableSubtitleText("Custom Quiz", textColor),
                        const SizedBox(height: 12,),
                        _quizOption(value, 2),

                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List instruction = [
    "1 point awarded for a correct answer and no marks for incorrect answer",
    "Tap on options to select the correct answer before timer expired",
    "To skip the quiz till chapter 3 tap on the start here button"
  ];

  /* Summary:
  * Show bottom sheet -> Displaying the selected chapters;
  * Instructions of the quiz;
  * Button to skip test through the selected Chapter
  * */
  _showBottomSheet(BuildContext context, DataManager value, int course, int index) {
    int? selectedQuiz;

    switch (course) {
      case 0: selectedQuiz = index; break;
      case 1: selectedQuiz = index + 4; break;
      case 2: selectedQuiz = index + 6; break;
      default : selectedQuiz = index;
    }
    return showBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 490, width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 8, left: 24, right: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Center(
                child: Container(
                  width: 80, height: 8,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(15)
                  ),
                ),
              ),
              
              const SizedBox(height: 24,),
              Center(
                child: reusableSubtitleText(
                  value.quizList[selectedQuiz!].name,
                  textColor
                ),
              ),
              const SizedBox(height: 16,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Icon
                  Container(
                    padding: const EdgeInsets.only(left: 3),
                    width: 40, height: 40,
                    decoration: const BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle
                    ),
                    child: const Icon(CupertinoIcons.doc, color: Colors.white,),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      reusableText("5 Question", textColor),
                      Text(
                        "1 point for each correct answer",
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: grey
                        ),
                      )
                    ],
                  )
                  // Message
                ],
              ),
              const SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Icon
                  Container(
                    padding: const EdgeInsets.only(top: 2, left: 1),
                    width: 40, height: 40,
                    decoration: const BoxDecoration(
                        color: primaryColor,
                        shape: BoxShape.circle
                    ),
                    child: const Icon(CupertinoIcons.clock, color: Colors.white,),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      reusableText("1min per Question", textColor),
                      Text(
                        "10min total duration of the quiz",
                        style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: grey
                        ),
                      )
                    ],
                  )
                  // Message
                ],
              ),
              const SizedBox(height: 24,),

              reusableSubtitleText(
                'Please read the instruction below to understand the mechanics',
                textColor,
              ),
              const SizedBox(height: 10,),

              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: instruction.length,
                itemBuilder: (context, index) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 6.0),
                      child: Container(
                        width: 10, height: 10,
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle
                        ),
                      ),
                    ),
                    const SizedBox(width: 12,),
                    Expanded(
                      child: reusableText(instruction[index], textColor),
                    )
                  ],
                )
              ),
              const SizedBox(height: 10,),

              MaterialButton(
                  minWidth: 132,
                  height: 46,
                  elevation: 0,
                  color: primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  onPressed: ()=> Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => QuizRuntimeScreen(
                      courseIndex: course,
                      selectedQuiz: index,
                      key: UniqueKey(),
                    ))
                  ),
                  child: reusableSubtitleText('Start here', Colors.white)
              )
            ],
          ),
        ),
      )
    );
  }

  /* Summary:
  * Display the quiz options
  * Item -> list of topic in software engineering course eg. softEng1 chapter or SoftEng2 chapter
  * OnTap -> Show the bottom sheet
  * */
  _quizOption(DataManager value, int course) {
    int quizNum;
    switch(course) {
      case 0 : quizNum = value.getSoftwareEngineering()[0].length; break;
      case 1 : quizNum = value.getSoftwareEngineering()[1].length; break;
      case 2 : quizNum = value.quizList.length - (value.getSoftwareEngineering()[0].length + value.softwareEngineering[1].length); break;
      default: quizNum = 0; break;
    }

    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: quizNum,//course == 0 ? value.getSoftwareEngineering()[0].length : course == 1 ? value.getSoftwareEngineering()[1].length : value.quizList.length - (value.getSoftwareEngineering()[0].length + value.softwareEngineering[1].length),
        itemBuilder: (context, index) {
          int? selectedQuiz;

          switch (course) {
            case 0: selectedQuiz = index; break;
            case 1: selectedQuiz = index + 8; break;
            case 2: selectedQuiz = index + 11; break;
            default : selectedQuiz = index;
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: MaterialButton(
              onPressed: () => _showBottomSheet(context, value, course, index),
              padding: const EdgeInsets.all(16),
              minWidth: MediaQuery.of(context).size.width,
              color: value.quizList[course == 0 ? index : course == 1 ? index + value.getSoftwareEngineering()[0].length : index + value.getSoftwareEngineering().length] // check if soft eng 1 or 2 if soft eng 2 and the length of soft eng 1 to index else use initial index
                  .isCompleted == true ? lGreen : Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: const BorderSide(color: lGrey)
              ),
              child: SizedBox(
                width: double.infinity,
                child: reusableText(
                    value.quizList[selectedQuiz].name,
                    textColor
                ),
              ),
            ).animate().slideX(
                begin: 2, duration: 1000.ms, delay: Duration(milliseconds: index * 200)).then()
                .fade(duration: 100.ms),
          );
        }
    );
  }

  /* Summary:
  * Header -> Display Catch phrase
  * Button for quiz run time starting from the first quiz
  * */
  _header(DataManager value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: reusableTitleText("Let's test your knowledge!", textColor),
        ),

        // Try Quiz Button
        MaterialButton(
          minWidth: 132,
          height: 46,
          elevation: 0,
          color: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onPressed: () => value.status == 'teacher' ?
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const AddNewQuiz()))
                      : Navigator.push(context, MaterialPageRoute(builder: (context) => QuizRuntimeScreen(courseIndex: 0, selectedQuiz: 0, key: UniqueKey(),))),
          //onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => QuizRuntimeScreen(courseIndex: 0, selectedQuiz: 0, key: UniqueKey(),))),
          child: reusableSubtitleText(value.status == 'teacher' ? 'Add Quiz' : 'Start here', Colors.white)
        )
      ],
    );
  }
}
