import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ClubAddPage extends StatefulWidget {
  @override
  _ClubAddPageState createState() => _ClubAddPageState();
}

class _ClubAddPageState extends State<ClubAddPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController aboutClubController = TextEditingController();
  final TextEditingController compulsoryController = TextEditingController();
  final TextEditingController forwhoController = TextEditingController();
  final TextEditingController activityController = TextEditingController();

  Future<void> uploadClub() async {
    try {
      final String name = nameController.text;
      final String category = categoryController.text;
      final String description = descriptionController.text;
      final String aboutClub = aboutClubController.text;
      final String compulsory = compulsoryController.text;
      final String forwho = forwhoController.text;
      final String activity = activityController.text;
      final String docId = DateTime.now().millisecondsSinceEpoch.toString();

      DocumentReference docRef =
          await FirebaseFirestore.instance.collection('club').doc(docId);
      docRef.set({
        'docId': docId,
        'name': name,
        'category': category,
        'description': description,
        'aboutClub': aboutClub,
        'compulsory': compulsory,
        'forwho': forwho,
        'activity': activity,
      });

      nameController.clear();
      categoryController.clear();
      descriptionController.clear();
      aboutClubController.clear();
      compulsoryController.clear();
      forwhoController.clear();
      activityController.clear();

      print('Club data uploaded successfully!');
    } catch (e) {
      print('Error uploading club data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: TextButton(
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
          child: const Text(
            "Cancel",
            softWrap: false,
            overflow: TextOverflow.visible,
          ),
        ),
        centerTitle: true,
        title: const Text('Add Club'),
        actions: <Widget>[
          TextButton(
            onPressed: uploadClub,
            child: Text("Save"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Club Name'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: categoryController,
                decoration: InputDecoration(labelText: 'Category'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: aboutClubController,
                decoration: InputDecoration(labelText: 'About Club'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: compulsoryController,
                decoration: InputDecoration(labelText: 'Compulsory'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: forwhoController,
                decoration: InputDecoration(labelText: 'For Who'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: activityController,
                decoration: InputDecoration(labelText: 'Activity'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
