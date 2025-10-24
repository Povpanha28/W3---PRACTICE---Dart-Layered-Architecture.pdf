import 'dart:io';
import '../domain/quiz.dart';
import 'package:uuid/uuid.dart';

class QuizConsole {
  var id = Uuid();
  Quiz quiz;

  QuizConsole({required this.quiz});

  void startQuiz() {
    print('--- Welcome to the Quiz ---\n');

    while (true) {
      // Ask for player name
      stdout.write('Enter player name (press Enter to quit): ');
      String? nameInput = stdin.readLineSync();

      // Exit condition
      if (nameInput == null || nameInput.trim().isEmpty) {
        print('\nExiting the quiz...');
        break;
      }

      nameInput = nameInput.trim();

      Player player = Player(name: nameInput, id: id.v4());
      quiz.addPlayer(player);

      for (var p in quiz.players) {
        print(p.name);
      }

      // clear the previous answers :

      quiz.answers.clear();

      // Ask questions

      for (var question in quiz.questions) {
        print('\nQuestion: ${question.title} - (${question.score} points)');
        print('Choices: ${question.choices}');
        stdout.write('Your answer: ');

        String? userInput = stdin.readLineSync();

        if (userInput != null && userInput.isNotEmpty) {
          // create and store answer
          Answer answer = Answer(question: question, answerChoice: userInput);
          quiz.addAnswer(answer);
        } else {
          print('No answer entered. Skipping question.');
        }
      }

// after collecting all answers:
      for (var a in quiz.answers) {
        print('Answer recorded: ${a.answerChoice}');
      }

      // one submission per player
      // IMPORTANT: pass a copy of quiz.answers so future clears/edits
      // don't mutate answers kept inside previous submissions.
      Submission submission =
          Submission(player: player, answers: List.from(quiz.answers));

      quiz.submitAnswer(submission);
      print('\nSubmission complete for ${player.name} ');

      print(quiz.submissions.length);

      // Calculate score
      int percentage = submission.calculatePercentage();
      // int score = quiz.getScore();

      // print('\n--- Quiz Finished for ${name} ---');
      print('Score: (${percentage}%)\n');
      // Show all players and scores
      print('--- Submission History ---');
      for (var s in quiz.submissions) {
        print('Player: ${s.player.name} : ${s.getScoreByPlayer(s.player)}');
      }
    }
  }
}
