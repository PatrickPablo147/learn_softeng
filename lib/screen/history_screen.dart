import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:software_engineering/const/colors.dart';
import 'package:software_engineering/database/data_manager.dart';
import 'package:software_engineering/utils/reusableText.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
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
                reusableTitleText("My Result's", textColor),
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
                      reusableSubtitleText("Quiz name", Colors.white),
                      reusableSubtitleText("Score", Colors.white)
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: value.quizResult.length,
                    itemBuilder: (context, index) => Container(
                      width: MediaQuery.of(context).size.width,
                      color: Colors.white,
                      padding: const EdgeInsets.only(top: 12, bottom: 12, left: 24, right: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: reusableText(value.getQuizResult()[index].quizName, textColor)),
                          reusableText(value.getQuizResult()[index].score.toString(), textColor)
                        ],
                      ),
                    ).animate().slideY(begin: 2, duration: 800.ms, delay: Duration(milliseconds: index * 200)).then().fadeIn(duration: 500.ms),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
