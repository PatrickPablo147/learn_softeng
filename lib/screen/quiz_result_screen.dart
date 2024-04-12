import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering/const/colors.dart';
import 'package:software_engineering/database/data_manager.dart';
import 'package:software_engineering/models/result.dart';
import 'package:software_engineering/services/firestore_service.dart';
import 'package:software_engineering/utils/reusableText.dart';

class QuizResultScreen extends StatefulWidget {
  final String quizId;
  final String quizName;

  const QuizResultScreen({required this.quizId, Key? key, required this.quizName}) : super(key: key);

  @override
  State<QuizResultScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<QuizResultScreen> {
  final FirestoreService _firestoreService = FirestoreService();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DataManager>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: bgColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 24, left: 16, right: 16, bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                reusableTitleText("${widget.quizName} Result's", textColor),
                const SizedBox(height: 28,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  decoration: const BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(12), topLeft: Radius.circular(12))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      reusableSubtitleText("Name", Colors.white),
                      reusableSubtitleText("Score", Colors.white)
                    ],
                  ),
                ),

                Expanded(
                  child: StreamBuilder(
                    stream: _firestoreService.getTargetQuizResult(widget.quizId),
                    builder: (context, snapshot) {
                      List results = snapshot.data?.docs ?? [];
                      print(widget.quizId);
                      print('results: $results');
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: results.length,
                        itemBuilder: (context, index) {
                          Result result = results[index].data();
                          return Container(
                            padding: const EdgeInsets.only(left: 26.0, right: 42, top: 8, bottom: 8),
                            color: index.isOdd ? Colors.grey.shade300 : Colors.transparent,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(child: reusableText(result.quizTakerName, Colors.black)),
                                reusableText(result.score.toString(), Colors.black),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  listResultView() {
    return Expanded(
      child: StreamBuilder(
          stream: _firestoreService.getCurrentUserResult(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator(); // Show a loading indicator while waiting for data
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            List results = snapshot.data?.docs ?? [];
            return ListView.builder(
              shrinkWrap: true,
              itemCount: results.length,
              itemBuilder: (context, index) {
                Result result = results[index].data();
                return Container(
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  padding: const EdgeInsets.only(top: 12, bottom: 12, left: 24, right: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(child: reusableText(result.quizName, textColor)),
                      reusableText(result.score.toString(), textColor)
                    ],
                  ),
                ).animate().slideY(begin: 2, duration: 800.ms, delay: Duration(milliseconds: index * 200)).then().fadeIn(duration: 500.ms);
              },
            );
          }
      ),
    );
  }
}
