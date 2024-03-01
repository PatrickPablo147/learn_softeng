import 'package:software_engineering/models/question.dart';

class Quiz {
  String name;
  bool isCompleted;
  List<Question> questions;

  Quiz({
    required this.name,
    this.isCompleted = false,
    required this.questions,
  });

  /*Quiz.fromJson(Map<String, Object?> json) : this(
    name: json('task')! as String,
    isCompleted: json('isCompleted')! as String,
    questions: json('questions')! as String
  );*/




}
