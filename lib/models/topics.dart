class Topic {
  int? topicValue;
  String? topicTitle;
  String? topicImage;
  bool isCompleted;

  Topic({
    required this.topicValue,
    required this.topicTitle,
    required this.topicImage,
    this.isCompleted = false
  });
}