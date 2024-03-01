import 'package:flutter/material.dart';
import '../models/lesson.dart';

class LessonSlideShare extends StatelessWidget {
  final int topicValue;
  final int courseIndex;
  const LessonSlideShare({Key? key, required this.topicValue, required this.courseIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Lesson lessonContent = Lesson();
    return PageView.builder(
      itemCount: lessonContent.getLessons()[courseIndex][topicValue].length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4.0),
          child: Image(image: AssetImage(lessonContent.getLessons()[courseIndex][topicValue][index]),),
        );
      }
    );
  }
}
