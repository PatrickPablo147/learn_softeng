class Option {
  String text;
  bool isCorrect;

  Option({
    required this.text,
    required this.isCorrect
  });

  Option.fromJson(Map<String, Object?> json) :
        this(
        text: json['text']! as String,
        isCorrect: json['isCorrect']! as bool,
      );

  Option copyWith({
    String? text,
    bool? isCorrect,
  }) {
    return Option(
      text: text ?? this.text,
      isCorrect: isCorrect ?? this.isCorrect,
    );
  }

  Map<String, Object> toJson() {
    return {
      'text' : text,
      'isCorrect' : isCorrect,
    };
  }
}