import 'dart:io';
import '../domain/quiz.dart';
import 'package:uuid/uuid.dart';

class QuizConsole {
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

      // Check if submission already exists
      Submission? existingSubmission = quiz.submissions.firstWhere(
        (s) => s.name.toLowerCase() == nameInput!.toLowerCase(),
        orElse: () =>
            Submission(id: quiz.id, name: '', quiz: Quiz(questions: [])),
      );

      Submission submission;
      if (existingSubmission.name.isNotEmpty) {
        submission = existingSubmission;
        submission.quiz = Quiz(id: Uuid().v4(), questions: quiz.questions);
      } else {
        submission = Submission(
            id: quiz.id,
            name: nameInput,
            quiz: Quiz(id: Uuid().v4(), questions: quiz.questions));
        quiz.addSubmission(submission);
      }

      // Ask questions
      for (var question in quiz.questions) {
        print('\nQuestion: ${question.title} - (${question.score} points)');
        print('Choices: ${question.choices}');
        stdout.write('Your answer: ');

        String? userInput = stdin.readLineSync();
        if (userInput != null && userInput.isNotEmpty) {
          Answer answer = Answer(question: question, answerChoice: userInput);
          submission.quiz.addAnswer(answer);
        } else {
          print('No answer entered. Skipping question.');
        }
      }

      // Calculate score
      int percentage = submission.quiz.getScoreInPercentage();
      int score = submission.quiz.getScore();
      submission.score = score; // overwrite old score

      print('\n--- Quiz Finished for ${submission.name} ---');
      print('Score: $score pts (${percentage}%)\n');

      // Show all players and scores
      print('--- Submission History ---');
      for (var s in quiz.submissions) {
        print('Player: ${s.name} : ${s.score}');
        print('Quiz id : ${quiz.id}');
        print('Submission id : ${s.id}');
      }
    }
  }
}
