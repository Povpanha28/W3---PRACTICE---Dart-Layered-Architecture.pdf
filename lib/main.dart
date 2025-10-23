import 'domain/quiz.dart';
import 'ui/quiz_console.dart';
import 'package:uuid/uuid.dart';

void main() {
  List<Question> questions = [
    Question(
        title: "Capital of France?",
        choices: ["Paris", "London", "Rome"],
        goodChoice: "Paris"),
    Question(title: "2 + 2 = ?", choices: ["2", "4", "5"], goodChoice: "4"),
  ];

  Quiz quiz = Quiz(id: Uuid().v4(), questions: questions);
  QuizConsole console = QuizConsole(quiz: quiz);

  console.startQuiz();
}
