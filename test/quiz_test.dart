// import 'package:my_first_project/domain/quiz.dart';
// import 'package:test/test.dart';

// void main() {
//   Question q1 =
//       Question(title: "4-2", choices: ["1", "2", "3"], goodChoice: "2");
//   Question q2 =
//       Question(title: "4+2", choices: ["1", "2", "3"], goodChoice: "6");

//   Quiz quiz = Quiz(questions: [q1, q2]);
//   Submission s1 = Submission(name: "Ronan", quiz: quiz);
//   Submission s2 = Submission(name: "Youdy", quiz: quiz);
//   setUp(() {});

//   test("test 1 - all correct answers & Player Ronan", () {
//     s1.quiz.answers = [
//       Answer(question: q1, answerChoice: "2"),
//       Answer(question: q2, answerChoice: "6"),
//     ];
//     expect(s1.quiz.getScoreInPercentage(), equals(100));
//     expect(s1.quiz.getScore(), equals(2));
//     expect(s1.name, "Ronan");
//   });

//   test("test 2 - all incorrect answers & Player Youdy", () {
//     s2.quiz.answers = [
//       Answer(question: q1, answerChoice: "7"),
//       Answer(question: q2, answerChoice: "9"),
//     ];

//     expect(s2.quiz.getScoreInPercentage(), equals(0));
//     expect(s2.quiz.getScore(), equals(0));
//     expect(s2.name, 'Youdy');
//   });
// }
