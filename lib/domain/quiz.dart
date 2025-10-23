// import 'package:uuid/uuid.dart';

class Question {
  final String title;
  final List<String> choices;
  final String goodChoice;
  final int score;

  Question(
      {required this.title,
      required this.choices,
      required this.goodChoice,
      this.score = 1});
}

class Answer {
  final Question question;
  final String answerChoice;

  Answer({required this.question, required this.answerChoice});

  bool isGood() {
    return this.answerChoice == question.goodChoice;
  }
}

class Player {
  String? id;
  final String name;
  int score;
  Quiz quiz;

  Player({required this.name, required this.quiz, this.score = 0, this.id});
}

class Submission {
  String? id;
  final String name;
  int score;
  Quiz quiz;

  Submission({required this.name, required this.quiz, this.score = 0, this.id});
}

class Quiz {
  String? id;
  List<Question> questions;
  List<Answer> answers = [];
  List<Player> players = [];
  List<Submission> submissions = [];

  Quiz({this.id, required this.questions});

  void addAnswer(Answer asnwer) {
    this.answers.add(asnwer);
  }

  void addPlayer(Player player) {
    this.players.add(player);
  }

  void addSubmission(Submission submission) {
    this.submissions.add(submission);
  }

  int getScoreInPercentage() {
    int correctCount = 0;
    for (Answer answer in answers) {
      if (answer.isGood()) {
        correctCount++;
      }
    }
    return ((correctCount / questions.length) * 100).toInt();
  }

  int getScore() {
    int totalScore = 0;
    for (Answer answer in answers) {
      if (answer.isGood()) {
        totalScore++;
      }
    }
    return totalScore;
  }
}
