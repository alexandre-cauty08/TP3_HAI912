// ignore_for_file: file_names

class Question {
  late String questionText;
  late bool reponse;
  late String thematic;
  late String imagePath;

  Question(
      {required this.questionText,
      required this.reponse,
      required this.thematic,
      required this.imagePath});

  Question.fromJson(Map<String, dynamic> json)
  {
    questionText = json['questionText'] ?? '';
    reponse = json['reponse'] ?? true;
    thematic = json['thematic'] ?? '';
    imagePath = json['imagePath'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'questionText': questionText,
      'reponse': reponse,
      'thematic': thematic,
      'imagePath': imagePath,
    };
  }
}
