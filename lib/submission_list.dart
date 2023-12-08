import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lets_crew/app_state.dart';
import 'package:lets_crew/model/recruiting_model.dart';
import 'package:provider/provider.dart';

import 'model/club_model.dart';

class SubmissionListPage extends StatefulWidget {
  final ClubModel club;
  const SubmissionListPage({super.key, required this.club});

  @override
  State<SubmissionListPage> createState() => _SubmissionListPageState();
}

class _SubmissionListPageState extends State<SubmissionListPage> {
  var currentIndex = 0;

  List<Widget> _buildRecruitingFormFields(
      List<RecruitingQuestions> recruitings) {
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
              return Text(
                recruiting.submissions[currentIndex]
                    .answers[index], // You can set initial values if needed
              );
            }),
          ),
        );
        formFields.add(Divider());
      }
    }

    return formFields;
  }

  @override
  Widget build(BuildContext context) {
    context.read<AppState>().fetchLatestRecruitingData(widget.club);
    return Scaffold(
      appBar: AppBar(
        title: Text('SUBMISSON LIST'),
      ),
      body: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Consumer<AppState>(builder: (context, appState, _) {
            if (appState.recruitings.isNotEmpty) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        if (currentIndex > 0) {
                          setState(() {
                            currentIndex--;
                          });
                        }
                      },
                      icon: Icon(
                        Icons.arrow_left_sharp,
                        color:
                            ((currentIndex > 0) ? Colors.black : Colors.grey),
                      )),
                  Text(
                      "${currentIndex + 1} / ${appState.recruitings[0].submissions.length}"),
                  IconButton(
                      onPressed: () {
                        if (currentIndex <
                            appState.recruitings[0].submissions.length - 1) {
                          setState(() {
                            currentIndex++;
                          });
                        }
                      },
                      icon: Icon(
                        Icons.arrow_right_sharp,
                        color: ((currentIndex <
                                appState.recruitings[0].submissions.length - 1)
                            ? Colors.black
                            : Colors.grey),
                      )),
                ],
              );
            } else
              return Text("No recruiting!");
          }),
          Consumer<AppState>(
            builder: (context, appState, _) {
              if (appState.recruitings.isNotEmpty) {
                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ..._buildRecruitingFormFields(appState.recruitings)
                      ],
                    ),
                  ),
                );
              }
              return SizedBox(
                height: 5,
              );
            },
          )
        ]),
      ),
    );
  }
}
