import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering/const/colors.dart';
import 'package:software_engineering/screen/quiz_result_screen.dart';
import 'package:software_engineering/services/firestore_service.dart';
import 'package:software_engineering/utils/reusableText.dart';
import '../database/data_manager.dart';
import '../models/quiz.dart';

class TeacherPanelScreen extends StatefulWidget {
  const TeacherPanelScreen({Key? key}) : super(key: key);

  @override
  State<TeacherPanelScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<TeacherPanelScreen> {
  final FirestoreService firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataManager>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 24, left: 12, right: 12, bottom: 12),
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //title
                      reusableTitleText("My Software \nEngineering Panel", primaryColor),
                      const SizedBox(height: 42,),

                      reusableSubtitleText('Created Quiz: ', Colors.black),

                      quizListView()
                    ],
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }

  quizListView() {
    return StreamBuilder(
      stream: firestoreService.getCurrentUserQuiz(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Show a loading indicator while waiting for data
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        List quizzes = snapshot.data?.docs ?? [];
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: quizzes.length,
          itemBuilder: (context, index) {
            Quiz quiz = quizzes[index].data();
            String quizId = quizzes[index].id;
            return Animate(
              key: ValueKey<int>(index),
              effects: [FadeEffect(
                  duration: 1000.ms,
                  delay: Duration(milliseconds: index * 400),
                  curve: Curves.easeInOut
              )],
              child: GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) =>
                    QuizResultScreen(quizName: quiz.name, quizId: quizId) )),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: index.isEven ? Colors.grey.shade200 : Colors.grey.shade400,
                  ),
                  child: Text(quiz.name)
                ),
              ),
            );
          }
        );
      }
    );
  }
}
