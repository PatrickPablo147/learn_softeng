import 'package:software_engineering/models/question.dart';

class Quiz {
  String? token;
  String name;
  bool isCompleted;
  List<Question> questions;

  Quiz({
    required this.token,
    required this.name,
    this.isCompleted = false,
    required this.questions,
  });

  Quiz.fromJson(Map<String, Object?> json) :
        this(
        token: json['token'] as String,
        name: json['name'] as String,
        isCompleted: json['isCompleted']! as bool,
        questions: (json['questions'] as List<dynamic>).map((questionJson) =>
            Question.fromJson(questionJson)).toList(),
      );

  Quiz copyWith({
    String? token,
    String? name,
    bool? isCompleted,
    List<Question>? questions,
  }) {
    return Quiz(
      token: token ?? this.token,
      name: name ?? this.name,
      isCompleted: isCompleted ?? this.isCompleted,
      questions: questions ?? this.questions,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'name': name,
      'isCompleted': isCompleted,
      'questions': questions.map((question) => question.toJson()).toList(),
    };
  }


}
