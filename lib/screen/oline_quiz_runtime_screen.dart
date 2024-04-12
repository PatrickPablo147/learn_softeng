import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering/database/data_manager.dart';
import 'package:software_engineering/models/question.dart';
import 'package:software_engineering/models/result.dart';
import 'package:software_engineering/screen/result_screen.dart';
import 'package:software_engineering/services/auth_service.dart';
import 'package:software_engineering/services/firestore_service.dart';
import '../const/colors.dart';
import '../models/option.dart';
import '../models/quiz.dart';
import '../utils/reusableText.dart';

/* PATTY DEV
* This handles the running of QUIZ
* - Get the quiz from generated QUIZ list
* - Display quiz
* - Set timer for quiz
* - Count correct score
* */

class OnlineQuizRuntimeScreen extends StatefulWidget {
  final String token;
  const OnlineQuizRuntimeScreen({Key? key, required this.token}) : super(key: key);

  @override
  State<OnlineQuizRuntimeScreen> createState() => _OnlineQuizRuntimeScreenState();
}

class _OnlineQuizRuntimeScreenState extends State<OnlineQuizRuntimeScreen> {
  late PageController _pageController;
  late ValueNotifier<int> _questionNumberNotifier;

  final CountDownController _countDownController = CountDownController();
  final AuthService _firebaseAuth = AuthService();
  final FirestoreService _firestoreService = FirestoreService();

  String? userUID;
  String? userName;

  int score = 0;
  bool isLocked = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _questionNumberNotifier = ValueNotifier<int>(1);

    _firebaseAuth.getCurrentUID().then((uid) {
      // Use the UID as needed
      userUID = uid;
    });

    _firebaseAuth.getCurrentDisplayName().then((uid) {
      // Use the UID as needed
      userName = uid;
    });

    print('init state');
    print('token: $userName');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataManager>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 24, left: 12, right: 12, bottom: 12),
            child: StreamBuilder(
              stream: _firestoreService.getTargetQuiz(widget.token),
              builder: (context, snapshot) {
                // Check if data is available
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // Show a loading indicator while waiting for data
                  return const Center(
                    child: CircularProgressIndicator(), // Or any other loading indicator widget
                  );
                } else if (!snapshot.hasData) {
                  // If there's no data, display a message
                  return const Center(
                    child: Text('No data available'),
                  );
                }

                // Filter quizzes based on token (document ID)\
                List quizzes = snapshot.data?.docs ?? [];

                return FutureBuilder<Quiz>(
                    future: Future.value(quizzes.isNotEmpty ? quizzes.first.data() : null),
                    builder: (context, quizSnapshot) {
                      if (quizSnapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (quizSnapshot.hasError) {
                        return const Center(
                          child: Text('Error fetching quiz data'),
                        );
                      } else if (!quizSnapshot.hasData) {
                        return const Center(
                          child: Text('No quiz data available'),
                        );
                      }

                      // Quiz data is available, call questionCard with the retrieved quiz
                      return buildWidget(quizSnapshot.data!);
                    }
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  buildWidget(Quiz quiz) {
    return Column(
      children: [
        //header
        header(quiz.name, quiz.questions.length),
        const SizedBox(height: 32,),
        reusableTitleText(
            quiz.name,
            textColor
        ),
        const SizedBox(height: 12,),

        //Questions Container
        questionCard(quiz)

      ],
    );
  }

  questionCard(Quiz quiz) {
    List<Question> question = quiz.questions;
    int quizLength = question.length;
    print('quizLength: $quizLength');

    return Expanded(
      child: ValueListenableBuilder(
        valueListenable: _questionNumberNotifier,
        builder: (context, questionNumber, child) {
          return PageView.builder(
            controller: _pageController,
            itemCount: quizLength,
            onPageChanged: (index) {
              //_questionNumberNotifier.value = index + 1;
              print('Notifier value: ${_questionNumberNotifier.value}');
            },
            //physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              Question currentQuestion = question[index];
              print('index: $index');
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
                              currentQuestion.text,
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
                          _questionNumberNotifier.value++;
                          if (_pageController.page!.round() + 1 < quizLength) {

                            Future.delayed(const Duration(milliseconds: 250), () {
                              _pageController.nextPage(
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeInOut,
                              );
                            });
                          }
                          else {
                            if(score > quizLength / 2) {
                              // Set isCompleted to true for the selected topic in the selected quiz
                            }

                            // store to online database
                            _firestoreService.addResult(Result(
                                userToken: userUID!,
                                takenQuizId: widget.token,
                                quizTakerName: userName!,
                                quizName: quiz.name,
                                score: score,
                            ));

                            Navigator.push(context, MaterialPageRoute(builder: (context) => ResultScreen(
                              courseIndex: 1,
                              selectedQuiz: 1,
                              score: score,
                              total: quizLength,
                              token: widget.token,
                            )
                            ));
                          }
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
                      child: optionWidget(question[index], quiz.name, quizLength),
                    ),
                  ),
                ],
              );
            },
          );
        },
      )
    );
  }

  optionWidget(Question question, String quizName, int questionLength) {
    void onClickedOption(Option option) {
      print('on clicked');
      if (question.isLocked) {
        print('locked');
        return;
      } else {
        question.isLocked = true;
        question.selectedOption = option;
        // Update score
        if (question.selectedOption!.isCorrect) {
          score++;
          print('score: $score');
        }
        isLocked = question.isLocked;

        _questionNumberNotifier.value++;
        // Move to the next question
        Future.delayed(const Duration(milliseconds: 250), () {
          if (_pageController.page!.round() + 1 < questionLength) {
            _pageController.nextPage(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
            );
            print('hit page: ${_pageController.page}');
          } else {
            // store to online database
            _firestoreService.addResult(Result(
                userToken: userUID!,
                takenQuizId: widget.token,
                quizName: quizName,
                score: score, quizTakerName: userName!,
            ));

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ResultScreen(
                  courseIndex: 1,
                  selectedQuiz: 1,
                  score: score,
                  total: questionLength,
                  token: widget.token,
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
            Expanded(child: reusableText(option.text, textColor)),
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

  void resetState(Quiz quiz) {
    setState(() {
      score = 0;
      isLocked = false;
      for (var question in quiz.questions) {
        question.isLocked = false;
        question.selectedOption = null;
      }
    });
  }

  header(String quizName, int questionLength) {
    return ValueListenableBuilder<int>(
      valueListenable: _questionNumberNotifier,
      builder: (context, questionNumber, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            reusableText('Question $questionNumber | $questionLength', textColor),
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
                            courseIndex: 1,
                            selectedQuiz: 1,
                            score: score,
                            total: questionLength,
                            token: widget.token,
                          )
                      )
                  );

                  // store to online database
                  _firestoreService.addResult(Result(
                      userToken: userUID!,
                      takenQuizId: widget.token,
                      quizName: quizName,
                      score: score, quizTakerName: userName!,
                  ));
                },
                child: reusableSubtitleText('Give Up' , Colors.white)
            ),
          ],
        );
      },
    );
  }

}
