import 'package:flutter/material.dart';
import 'package:software_engineering/models/lesson.dart';
import 'package:software_engineering/utils/reusableText.dart';
import '../const/colors.dart';

class Lesson1 extends StatelessWidget {
  const Lesson1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Lesson lessonContent = Lesson();

    return PageView(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          height: 210,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: reusableTitleText(
                'Chapter 1: Introduction',
                textColor
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          height: 210,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              reusableText(
                lessonContent.lesson1[0][0],
                textColor
              ),
              const SizedBox(height: 8,),
              reusableText(
                lessonContent.lesson1[0][1],
                textColor
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          height: 210,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              reusableSubtitleText(lessonContent.lesson1[0][2], textColor),
              const SizedBox(height: 8,),
              reusableText(
                lessonContent.lesson1[0][3],
                textColor
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          height: 210,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              reusableSubtitleText(lessonContent.lesson1[0][2], textColor),
              const SizedBox(height: 8,),
              reusableText(
                  lessonContent.lesson1[0][4],
                  textColor
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          height: 210,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              reusableSubtitleText('Software Engineering Definitions:', textColor),
              const SizedBox(height: 8,),
              reusableText(
                  lessonContent.lesson1[0][5],
                  textColor
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          height: 210,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              reusableSubtitleText(lessonContent.lesson1[0][6], textColor),
              const SizedBox(height: 8,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      reusableText(
                          lessonContent.lesson1[0][7],
                          textColor
                      ),
                      reusableText(
                          lessonContent.lesson1[0][8],
                          textColor
                      ),
                      reusableText(
                          lessonContent.lesson1[0][9],
                          textColor
                      ),
                      reusableText(
                          lessonContent.lesson1[0][10],
                          textColor
                      ),
                      reusableText(
                          lessonContent.lesson1[0][11],
                          textColor
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      reusableText(
                          lessonContent.lesson1[0][12],
                          textColor
                      ),
                      reusableText(
                          lessonContent.lesson1[0][13],
                          textColor
                      ),
                      reusableText(
                          lessonContent.lesson1[0][14],
                          textColor
                      ),
                      reusableText(
                          lessonContent.lesson1[0][15],
                          textColor
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          height: 210,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              reusableSubtitleText(lessonContent.lesson1[0][16], textColor),
              const SizedBox(height: 8,),
              reusableText(
                  lessonContent.lesson1[0][17],
                  textColor
              ),
              const SizedBox(height: 8,),
              reusableText(
                  lessonContent.lesson1[0][18],
                  textColor
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          height: 210,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              reusableSubtitleText(lessonContent.lesson1[0][16], textColor),
              const SizedBox(height: 4,),
              reusableText(
                  lessonContent.lesson1[0][19],
                  textColor
              ),
              const SizedBox(height: 8,),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          height: 210,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              reusableSubtitleText(lessonContent.lesson1[0][16], textColor),
              const SizedBox(height: 8,),
              reusableText(
                  lessonContent.lesson1[0][20],
                  textColor
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          height: 210,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              reusableSubtitleText(lessonContent.lesson1[0][21], textColor),
              const SizedBox(height: 8,),
              reusableText(
                  lessonContent.lesson1[0][22],
                  textColor
              ),
              reusableText(
                  lessonContent.lesson1[0][23],
                  textColor
              ),
              const SizedBox(height: 8,),
              reusableText(
                  lessonContent.lesson1[0][24],
                  textColor
              ),
            ],
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 24),
          height: 210,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              reusableSubtitleText(lessonContent.lesson1[0][21], textColor),
              const SizedBox(height: 8,),
              reusableText(
                  lessonContent.lesson1[0][25],
                  textColor
              ),
              reusableText(
                  lessonContent.lesson1[0][26],
                  textColor
              ),
            ],
          ),
        ),
      ],
    );
  }
}
