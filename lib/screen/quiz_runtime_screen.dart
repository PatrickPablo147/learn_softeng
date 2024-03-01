import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering/database/data_manager.dart';
import 'package:software_engineering/models/question.dart';
import 'package:software_engineering/screen/result_screen.dart';
import '../const/colors.dart';
import '../models/option.dart';
import '../utils/reusableText.dart';

/* PATTY DEV
* This handles the running of QUIZ
* - Get the quiz from generated QUIZ list
* - Display quiz
* - Set timer for quiz
* - Count correct score
* */

class QuizRuntimeScreen extends StatefulWidget {
  final int courseIndex;
  final int selectedQuiz;
  const QuizRuntimeScreen({Key? key, required this.selectedQuiz, required this.courseIndex}) : super(key: key);

  @override
  State<QuizRuntimeScreen> createState() => _QuizRuntimeScreenState();
}

class _QuizRuntimeScreenState extends State<QuizRuntimeScreen> {
  late PageController _pageController;
  final CountDownController _countDownController = CountDownController();
  int score = 0;
  int _questionNumber = 1;
  bool isLocked = false;
  int? _selectedQuiz;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    resetState(Provider.of<DataManager>(context, listen: false));

    switch (widget.courseIndex) {
      case 0: _selectedQuiz = widget.selectedQuiz; break;
      case 1: _selectedQuiz = widget.selectedQuiz + 8; break;
      case 2: _selectedQuiz = widget.selectedQuiz + 11; break;
      default : _selectedQuiz = widget.selectedQuiz;
    }
  }



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
                header(value),
                const SizedBox(height: 32,),
                reusableTitleText(
                  value.getQuizList()[_selectedQuiz!].name,
                  //'Chapter 1: What is software Engineering?',
                  textColor
                ),
                const SizedBox(height: 12,),

                //Questions Container
                questionCard(value)

              ],
            ),
          ),
        ),
      ),
    );
  }

  questionCard(DataManager value) {
    List<Question> question = value.getQuizList()[_selectedQuiz!].questions;

    return Expanded(
      child: PageView.builder(
        controller: _pageController,
        itemCount: question.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 190,
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                                color: shadowColor,
                                blurRadius: 15,
                                spreadRadius: 2,
                                offset: Offset(0, 4)
                            )
                          ]
                      ),
                      child: Center(child: reusableCenterText(
                        question[index].text,
                        textColor
                      )),
                    ),
                  ),
                  CircularCountDownTimer(
                    controller: _countDownController,
                    width: 80,
                    height: 90,
                    duration: 30,
                    fillColor: primaryColor,
                    backgroundColor: Colors.white,
                    ringColor: Colors.white,
                    strokeWidth: 10,
                    strokeCap: StrokeCap.round,
                    isReverse: true,
                    onComplete: () {
                      setState(() {
                        if (_questionNumber < value.getQuizList()[_selectedQuiz!].questions.length) {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 250),
                            curve: Curves.easeInOut
                          );
                          setState(() {
                            _questionNumber++;
                          });
                        } else {
                          if(score > value.getQuizList()[_selectedQuiz!].questions.length / 2) {
                            // Set isCompleted to true for the selected topic in the selected quiz
                            Provider.of<DataManager>(context, listen: false)
                                .getQuizList()[_selectedQuiz!].isCompleted = true;

                            // Notify listeners to rebuild widgets that depend on DataManager
                            //Provider.of<DataManager>(context, listen: false).notifyListeners();
                          }

                          Provider.of<DataManager>(context, listen: false).addResult(value.quizList[_selectedQuiz!].name, score);

                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ResultScreen(
                            courseIndex: widget.courseIndex,
                            selectedQuiz: widget.selectedQuiz,
                            score: score,
                            total: value.getQuizList()[_selectedQuiz!].questions.length)
                          ));
                        }
                      });
                    },
                    textStyle: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22,),

              //Option widget
              Expanded(
                child: SingleChildScrollView(
                  child: optionWidget(question[index], value),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  optionWidget(Question question, DataManager value) {
    void onClickedOption(Option option) {
      if (question.isLocked) {
        return;
      } else {
        setState(() {
          question.isLocked = true;
          question.selectedOption = option;
        });
        isLocked = question.isLocked;
        if(question.selectedOption!.isCorrect) {
          score++;
        }

        // Move to the next question
        Future.delayed(const Duration(seconds: 1), (){
          if (_questionNumber < value.getQuizList()[_selectedQuiz!].questions.length) {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
            );
            setState(() {
              _questionNumber++;
            });
          } else {
            if(score > value.getQuizList()[_selectedQuiz!].questions.length / 2) {
              // Set isCompleted to true for the selected topic in the selected quiz
              Provider.of<DataManager>(context, listen: false).markQuizCompleted(_selectedQuiz!);
            }

            Provider.of<DataManager>(context, listen: false).addResult(
                value.quizList[_selectedQuiz!].name,
                score
            );

            // If it's the last question, navigate to the ResultScreen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ResultScreen(
                  courseIndex: widget.courseIndex,
                  selectedQuiz: widget.selectedQuiz,
                  score: score,
                  total: value.getQuizList()[_selectedQuiz!].questions.length,
                ),
              ),
            );
          }
        });
      }
    }

    // Generate a column of buildOption with the item of class questions options
    return Column(
      children: question.options.map((option) =>
        buildOption(option, question, onClickedOption)
      ).toList()
    );
  }

  Widget buildOption(Option option, Question question, ValueChanged<Option> onClickedOption) {
    final containerColor = getContainerColorForOption(option, question);
    final borderColor = getBorderColorForOption(option, question);
    return GestureDetector(
      onTap: () => onClickedOption(option),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        width: double.infinity,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: reusableText(option.text!, textColor)),
            getIconForOption(option, question)
          ],
        ),
      ),
    );
  }

  getIconForOption(Option option, Question question) {
    final isSelected = option == question.selectedOption;
    if (question.isLocked) {
      if (isSelected) {
        return option.isCorrect
        ? const Icon(Icons.check_circle_rounded, color: green,)
        : const Icon(Icons.cancel, color: red,);
      } else if (option.isCorrect) {
        return const Icon(Icons.check_circle_rounded, color: green,);
      }
    }
    return Container(
      height: 21, width: 21,
      decoration: BoxDecoration(
        color: grey.withOpacity(0.2),
        shape: BoxShape.circle,
        border: Border.all(color: lGrey)
      ),
    );
  }

  Color getContainerColorForOption(Option option, Question question) {
    final isSelected = option == question.selectedOption;
    if (question.isLocked) {
      if (isSelected) {
        return option.isCorrect ? lGreen : lRed;
      } else if (option.isCorrect) {
        return lGreen;
      }
    }
    return Colors.white;
  }

  Color getBorderColorForOption(Option option, Question question) {
    final isSelected = option == question.selectedOption;
    if (question.isLocked) {
      if (isSelected) {
        return option.isCorrect ? green : red;
      } else if (option.isCorrect) {
        return green;
      }
    }
    return lGrey;
  }

  void resetState(DataManager value) {
    setState(() {
      _questionNumber = 1;
      score = 0;
      isLocked = false;
      for (var question in value.getQuizList()[widget.courseIndex == 0 ? widget.selectedQuiz : widget.selectedQuiz + 4].questions) {
        question.isLocked = false;
        question.selectedOption = null;
      }
    });
  }

  header(DataManager value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        reusableText('Question $_questionNumber | ${value.getQuizList()[_selectedQuiz!].questions.length}', textColor),
        MaterialButton(
            minWidth: 132,
            height: 46,
            elevation: 0,
            color: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) =>
                    ResultScreen(
                        courseIndex: widget.courseIndex,
                        selectedQuiz: widget.selectedQuiz,
                        score: score,
                        total: value.getQuizList()[widget.selectedQuiz].questions.length
                    )
                )
              );
              Provider.of<DataManager>(context, listen: false).addResult(
                  value.quizList[_selectedQuiz!].name,
                  score
              );
            },
            child: reusableSubtitleText('Give Up' , Colors.white)
        ),
      ],
    );
  }
}
