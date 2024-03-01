class Option {
  String? text;
  bool isCorrect;

  Option({
    required this.text,
    required this.isCorrect
  });

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'isCorrect': isCorrect,
    };
  }

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      text: json['text'],
      isCorrect: json['isCorrect'],
    );
  }
}