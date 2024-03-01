class Result {
  String quizName;
  int score;

  Result({
    required this.quizName,
    required this.score,
  });

  Map<String, dynamic> toJson() {
    return {
      'quizName': quizName,
      'score': score,
    };
  }

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      quizName: json['quizName'],
      score: json['score'],
    );
  }
}
