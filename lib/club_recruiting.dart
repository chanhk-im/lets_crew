import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lets_crew/app_state.dart';
import 'package:provider/provider.dart';
import 'model/club_model.dart';
import 'model/recruiting_model.dart';
import 'theme.dart';

class ClubRecruitingPage extends StatefulWidget {
  final ClubModel club;
  ClubRecruitingPage({required this.club});

  @override
  _ClubRecruitingPageState createState() => _ClubRecruitingPageState(club: club);
}

class _ClubRecruitingPageState extends State<ClubRecruitingPage> {
  ClubModel club;

  _ClubRecruitingPageState({required this.club});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Club Recruiting'),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Consumer<AppState>(builder: (context, appState, _) {
          appState.fetchLatestRecruitingData(club);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (appState.recruitings.isNotEmpty)
                Text(
                  'Recruiting Questions for ${club.name}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              Divider(),
              (appState.recruitings.isNotEmpty)
                  ? Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ..._buildRecruitingFormFields(appState.recruitings),
                          Spacer(),
                          ElevatedButton(
                            onPressed: () {
                              _submitAnswer(appState).then((_) => Navigator.pop(context));
                            },
                            child: Text('Submit Application'),
                          ),
                        ],
                      ),
                    )
                  : Text("No recruiting!"),
            ],
          );
        }),
      ),
    );
  }

  List<Widget> _buildRecruitingFormFields(List<RecruitingQuestions> recruitings) {
    List<Widget> formFields = [];
    for (var recruiting in recruitings) {
      for (var index = 0; index < recruiting.questions.length; index++) {
        var question = recruiting.questions[index];
        formFields.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              // Display the question as text
              question.question,
              style: TextStyle(fontSize: 16),
            ),
          ),
        );
        formFields.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Consumer<AppState>(builder: (context, appState, _) {
              return TextFormField(
                initialValue: '', // You can set initial values if needed
                decoration: InputDecoration(
                  labelText: 'Your Answer',
                  border: OutlineInputBorder(),
                ),
                onChanged: (response) {
                  // Save the response to Firebase or a local variable as needed
                  appState.addAnswers(response, index);
                },
              );
            }),
          ),
        );
      }
    }

    return formFields;
  }

  Future<void> _submitAnswer(AppState appState) async {
    // Implement the logic to save applicant's responses to Firebase
    // This might involve creating a new collection to store applicant data
    // and associating it with the recruiting form ID.
    DocumentReference docReference = FirebaseFirestore.instance
        .collection('club')
        .doc(club.docId)
        .collection('recruiting_questions')
        .doc(appState.recruitings[0].id);
    await appState.fetchLatestRecruitingDataWithoutUpdate(club);
    final uidIndex = appState.recruitings[0].submissions
        .indexWhere((element) => element.uid == FirebaseAuth.instance.currentUser!.uid);
    if (uidIndex >= 0) {
      appState.updateRecruitingAnswer(uidIndex);
      docReference.update({
        'submissions': List<Map<String, dynamic>>.from(appState.recruitings[0].submissions.map(
          (e) => e.toJson(),
        )),
      });
    } else {
      docReference.update({
        'submissions': [
          ...List<Map<String, dynamic>>.from(appState.recruitings[0].submissions.map(
            (e) => e.toJson(),
          )),
          {"uid": FirebaseAuth.instance.currentUser!.uid, "answers": appState.answers}
        ]
      });
    }
  }
}
