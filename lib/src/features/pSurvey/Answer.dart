class Answer {
  final int id;
  final String option;
  final String createdAt;
  final int question;
  final int createdBy;

  Answer({
    required this.id,
    required this.option,
    required this.createdAt,
    required this.question,
    required this.createdBy,
  });

  // Factory constructor to create an Answer from a JSON object
  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: json['id'],
      option: json['option'],
      createdAt: json['created_at'],
      question: json['question'],
      createdBy: json['created_by'],
    );
  }

  // Convert the Answer instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'option': option,
      'created_at': createdAt,
      'question': question,
      'created_by': createdBy,
    };
  }

  // Getter methods
  int get getId => id;
  String get getOption => option;
  int get getQuestion => question;
}
