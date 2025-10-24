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
  // List<Answer> playerAnswers = [];

  Player({required this.name, this.id});

  // void addPlayerAnswer(Answer answer) {
  //   playerAnswers.add(answer);
  // }
}

class Submission {
  final Player player;
  final List<Answer> answers;

  Submission({required this.player, required this.answers});

  int calculateScore() {
    int total = 0;
    for (var a in answers) {
      if (a.isGood()) total += a.question.score;
    }
    return total;
  }

  int calculatePercentage() {
    if (answers.isEmpty) return 0;
    int correct = answers.where((a) => a.isGood()).length;
    return ((correct / answers.length) * 100).toInt();
  }

  Map<String, int> getScoreByPlayer(Player player) {
    if (player.id == this.player.id) {
      return {
        'score': calculateScore(),
        'percentage': calculatePercentage(),
      };
    }
    return {};
  }
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
    final index = players.indexWhere((p) => p.name == player.name);
    if (index == -1) {
      players.add(player);
    } else {
      players[index] = player; // Overwrite existing player's data
    }
  }

  void submitAnswer(Submission submission) {
    submissions.add(submission);
  }
}
