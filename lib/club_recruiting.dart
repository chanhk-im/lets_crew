import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'model/club_model.dart';
import 'theme.dart';

class ClubRecruitingPage extends StatefulWidget {
  final ClubModel club;
  ClubRecruitingPage({required this.club});

  @override
  _ClubRecruitingPageState createState() =>
      _ClubRecruitingPageState(club: club);
}

class _ClubRecruitingPageState extends State<ClubRecruitingPage> {
  ClubModel club;
  List<dynamic>? recruitingQuestions;

  _ClubRecruitingPageState({required this.club});

  @override
  void initState() {
    super.initState();
    fetchLatestRecruitingData();
  }

  void fetchLatestRecruitingData() async {
    DocumentReference clubRef =
        FirebaseFirestore.instance.collection('club').doc(club.docId);
    CollectionReference recruitingForm =
        clubRef.collection('recruiting_questions');

    QuerySnapshot querySnapshot = await recruitingForm
        .orderBy('timestamp', descending: true)
        .limit(1)
        // Remove the limit to fetch all documents
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      // Access all documents in the result
      List<Map<String, dynamic>> allData = [];

      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;
        allData.add(data);
      }

      // Further processing, such as updating the UI with allData
      setState(() {
        recruitingQuestions = allData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Club Recruiting'),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (recruitingQuestions != null)
              Text(
                'Recruiting Questions for ${club.name}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            if (recruitingQuestions != null) Divider(),
            if (recruitingQuestions != null)
              ..._buildRecruitingFormFields(recruitingQuestions!),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Implement the logic to save applicant's responses to Firebase
                // This might involve creating a new collection to store applicant data
                // and associating it with the recruiting form ID.
              },
              child: Text('Submit Application'),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildRecruitingFormFields(List<dynamic> questions) {
    List<Widget> formFields = [];

    for (var question in questions) {
      formFields.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            // Display the question as text
            question['question'],
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
      formFields.add(
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            initialValue: '', // You can set initial values if needed
            decoration: InputDecoration(
              labelText: 'Your Answer',
              border: OutlineInputBorder(),
            ),
            onChanged: (response) {
              // Save the response to Firebase or a local variable as needed
            },
          ),
        ),
      );
    }

    return formFields;
  }
}
