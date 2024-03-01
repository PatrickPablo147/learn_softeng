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

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'options': options.map((o) => o.toJson()).toList(),
      'isLocked': isLocked,
      'selectedOption': selectedOption?.toJson(),
    };
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    // Add the following line to check the data types of the fields
    print('Text Type: ${json['text'].runtimeType}');
    print('Options Type: ${json['options'].runtimeType}');
    print('IsLocked Type: ${json['isLocked'].runtimeType}');
    print('SelectedOption Type: ${json['selectedOption']?.runtimeType}');

    return Question(
      text: json['text'],
      options: (json['options'] as List).map((o) => Option.fromJson(o)).toList(),
      isLocked: json['isLocked'] ?? false,
      selectedOption: json['selectedOption'] != null ? Option.fromJson(json['selectedOption']) : null,
    );
  }


}