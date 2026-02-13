import 'package:quiz_app_finesse/models/questionmodel.dart';

List<QuestionModel> questions = [
  QuestionModel(
    question_text: "What programming language is used to develop Flutter apps?",
    answers: ["Java", "Kotlin", "Dart", "Swift"],
    correctanswerindex: 2,
  ),
  QuestionModel(
    question_text: "Which widget is used for immutable layouts in Flutter?",
    answers: ["StatefulWidget", "StatelessWidget", "ContainerWidget", "BuildWidget"],
    correctanswerindex: 1,
  ),
  QuestionModel(
    question_text: "Which function is the entry point of every Flutter app?",
    answers: ["start()", "main()", "run()", "init()"],
    correctanswerindex: 1,
  ),
  QuestionModel(
    question_text: "What command is used to create a new Flutter project?",
    answers: [
      "flutter new project",
      "flutter create project_name",
      "flutter init",
      "dart create"
    ],
    correctanswerindex: 1,
  ),
  QuestionModel(
    question_text: "Which widget is commonly used for layout spacing?",
    answers: ["Padding", "Text", "Icon", "AppBar"],
    correctanswerindex: 0,
  ),
  QuestionModel(
    question_text: "Which widget allows scrolling in Flutter?",
    answers: ["Column", "Row", "ListView", "Stack"],
    correctanswerindex: 2,
  ),
  QuestionModel(
    question_text: "Where are dependencies added in a Flutter project?",
    answers: [
      "main.dart",
      "android/build.gradle",
      "pubspec.yaml",
      "dependencies.dart"
    ],
    correctanswerindex: 2,
  ),
  QuestionModel(
    question_text: "Which widget is used to create a button in Flutter?",
    answers: ["TextButton", "ButtonWidget", "ClickButton", "ActionView"],
    correctanswerindex: 0,
  ),
];
