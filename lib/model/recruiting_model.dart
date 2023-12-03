import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

RecruitingQuestions recruitingQuestionsFromJson(String str) => RecruitingQuestions.fromJson(json.decode(str));

String recruitingQuestionsToJson(RecruitingQuestions data) => json.encode(data.toJson());

class RecruitingQuestions {
  String id;
  String clubName;
  DateTime endDate;
  List<Question> questions;
  DateTime startDate;
  DateTime timeStamp;
  List<Submission> submissions;

  RecruitingQuestions({
    required this.id,
    required this.clubName,
    required this.endDate,
    required this.questions,
    required this.startDate,
    required this.timeStamp,
    required this.submissions,
  });

  factory RecruitingQuestions.fromJson(Map<String, dynamic> json) => RecruitingQuestions(
        id: json["id"],
        clubName: json["clubName"],
        endDate: DateTime.parse(json["endDate"]),
        questions: List<Question>.from(json["questions"].map((x) => Question.fromJson(x))),
        startDate: DateTime.parse(json["startDate"]),
        timeStamp: DateTime.parse(json["timeStamp"]),
        submissions: List<Submission>.from(json["submissions"].map((x) => Submission.fromJson(x))),
      );

  factory RecruitingQuestions.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return RecruitingQuestions(
      id: snapshot.id,
      clubName: data["clubName"],
      endDate: (data['endDate'] as Timestamp).toDate(),
      questions: List<Question>.from(data["questions"].map((x) => Question.fromJson(x))),
      startDate: (data['startDate'] as Timestamp).toDate(),
      timeStamp: (data['timestamp'] as Timestamp).toDate(),
      submissions: List<Submission>.from(data["submissions"].map((x) => Submission.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
        "clubName": clubName,
        "endDate": endDate.toIso8601String(),
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
        "startDate": startDate.toIso8601String(),
        "timeStamp": timeStamp.toIso8601String(),
      };
}

class Question {
  int lengthLong;
  String question;

  Question({
    required this.lengthLong,
    required this.question,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        lengthLong: json["lengthLong"],
        question: json["question"],
      );

  factory Question.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Question(
      lengthLong: data["lengthLong"],
      question: data["question"],
    );
  }

  Map<String, dynamic> toJson() => {
        "lengthLong": lengthLong,
        "question": question,
      };
}

class Submission {
    String uid;
    List<String> answers;

    Submission({
        required this.uid,
        required this.answers,
    });

    factory Submission.fromJson(Map<String, dynamic> json) => Submission(
        uid: json["uid"],
        answers: List<String>.from(json["answers"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "uid": uid,
        "answers": List<dynamic>.from(answers.map((x) => x)),
    };
}