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
  @override
  Widget build(BuildContext context) {
    context.read<AppState>().fetchLatestRecruitingData(widget.club);
    return Scaffold(
      appBar: AppBar(
        title: Text('SUBMISSON LIST'),
      ),
      body: Column(children: [
        Consumer<AppState>(builder: (context, appState, _) {
          if (appState.recruitings.isNotEmpty) {
            return Row(
              children: [
                IconButton(onPressed: () {}, icon: Icon(Icons.arrow_left_sharp)),
                Text("${currentIndex + 1} / ${appState.recruitings[0].submissions.length}"),
                IconButton(onPressed: () {}, icon: Icon(Icons.arrow_right_sharp)),
              ],
            );
          } else
            return Text("No recruiting!");
        }),
      ]),
    );
  }
}
