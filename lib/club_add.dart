import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

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
  final TextEditingController activity1Controller = TextEditingController();
  final TextEditingController activity2Controller = TextEditingController();
  final TextEditingController activity3Controller = TextEditingController();
  File? imageFile;
  List<String> activities =
      List.filled(3, ''); // Initialize list with three empty strings

  bool isSaving = false; // Track the saving state

  Future<void> uploadClub() async {
    setState(() {
      isSaving = true; // Set saving state to true when starting the upload
    });

    try {
      final String name = nameController.text;
      final String category = categoryController.text;
      final String description = descriptionController.text;
      final String aboutClub = aboutClubController.text;
      final String compulsory = compulsoryController.text;
      final String forwho = forwhoController.text;
      final String docId = DateTime.now().millisecondsSinceEpoch.toString();

      if (imageFile == null) {
        // Show alert or snackbar to inform the user to select an image
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Image Required'),
              content: Text('Please select an image before saving.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      }

      String imageUrl;
      final Reference storageReference =
          FirebaseStorage.instance.ref().child('club/$name.png');
      final UploadTask uploadTask = storageReference.putFile(imageFile!);
      await uploadTask.whenComplete(() => null);

      // Get the download URL of the uploaded image
      imageUrl = await storageReference.getDownloadURL();

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
        'activity': [
          activity1Controller.text,
          activity2Controller.text,
          activity3Controller.text,
        ],
        'imageUrl': imageUrl,
        'likes': [],
      });

      // Clear text controllers and activities list after successful upload
      nameController.clear();
      categoryController.clear();
      descriptionController.clear();
      aboutClubController.clear();
      compulsoryController.clear();
      forwhoController.clear();
      activity1Controller.clear();
      activity2Controller.clear();
      activity3Controller.clear();
      activities = List.filled(3, ''); // Reset activities list

      print('Club data uploaded successfully!');
    } catch (e) {
      print('Error uploading club data: $e');
    } finally {
      setState(() {
        isSaving =
            false; // Reset saving state after upload completes (success or failure)
      });
    }
  }

  Future<void> getImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);

      if (image != null) {
        imageFile = File(image.path);
      }
    } catch (e) {
      print('이미지 선택 오류: $e');
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
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () async {
                      // Call your getImage function here
                      await getImage();
                    },
                    child: Container(
                      width: 400.w,
                      height: 200.w,
                      decoration: ShapeDecoration(
                        color: Color.fromARGB(173, 255, 231, 143),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Click to Add Image File",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(labelText: 'Club Name'),
                  ),
                  TextField(
                    controller: categoryController,
                    decoration: InputDecoration(labelText: 'Category'),
                  ),
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(labelText: 'Description'),
                  ),
                  TextField(
                    controller: aboutClubController,
                    decoration: InputDecoration(labelText: 'About Club'),
                  ),
                  TextField(
                    controller: compulsoryController,
                    decoration: InputDecoration(labelText: 'Compulsory'),
                  ),
                  TextField(
                    controller: forwhoController,
                    decoration: InputDecoration(labelText: 'For Who'),
                  ),
                  TextField(
                    controller: activity1Controller,
                    decoration: InputDecoration(labelText: 'Activity 1'),
                  ),
                  TextField(
                    controller: activity2Controller,
                    decoration: InputDecoration(labelText: 'Activity 2'),
                  ),
                  TextField(
                    controller: activity3Controller,
                    decoration: InputDecoration(labelText: 'Activity 3'),
                  ),
                ],
              ),
            ),
          ),
          isSaving
              ? Column(children: [
                  Positioned.fill(
                    child: Container(
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                  Center(
                      child: Padding(
                    padding: EdgeInsets.only(top: 300.h),
                    child: CircularProgressIndicator(),
                  )),
                ])
              : SizedBox()
        ],
      ),
    );
  }
}
