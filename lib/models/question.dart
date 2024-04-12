import 'option.dart';

class Question {
  late String text;
  final List<Option> options;
  bool isLocked;
  Option? selectedOption;

  Question({
    required this.text,
    required this.options,
    this.isLocked = false,
    this.selectedOption,
  });

  Question.fromJson(Map<String, dynamic> json) :
        this(
          text: json['text']! as String,
          options: (json['options'] as List<dynamic>).map((e) => Option.fromJson(e)).toList(),
          isLocked: json['isLocked']! as bool,
          selectedOption: null,
      );

  Question copyWith({
    String? text,
    List<Option>? options,
    bool? isLocked,
    Option? selectedOption
  }) {
    return Question(
      text: text ?? this.text,
      options: options ?? this.options,
      isLocked: isLocked ?? this.isLocked,
      selectedOption: selectedOption ?? this.selectedOption
    );
  }

  Map<String, Object> toJson() {
    return {
      'text' : text,
      'options' : options.map((option) => option.toJson()).toList(),
      'isLocked' : isLocked,
      'selectedOption' : selectedOption == null,
    };
  }


}