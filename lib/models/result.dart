class Result {
  String userToken;
  String takenQuizId;
  String quizTakerName;
  String quizName;
  int score;

  Result({
    required this.userToken,
    required this.takenQuizId,
    required this.quizTakerName,
    required this.quizName,
    required this.score,
  });

  Result.fromJson(Map<String, Object?> json) :
      this(
        userToken: json['token']! as String,
        takenQuizId: json['quizId']! as String,
        quizTakerName: json['quizTakerName']! as String,
        quizName: json['quizName']! as String,
        score: json['score']! as int,
      );

  Result copyWith({
    String? userToken,
    String? takenQuizId,
    String? quizTakerName,
    String? quizName,
    int? score,
  }) {
    return Result(
      userToken: userToken ?? this.userToken,
      takenQuizId: takenQuizId ?? this.takenQuizId,
      quizTakerName: quizName ?? this.quizTakerName,
      quizName: quizName ?? this.quizName,
      score: score ?? this.score,
    );
  }

  Map<String, Object> toJson() {
    return {
      'token' : userToken,
      'quizId' : takenQuizId,
      'quizTakerName' : quizTakerName,
      'quizName' : quizName,
      'score' : score,
    };
  }
}
