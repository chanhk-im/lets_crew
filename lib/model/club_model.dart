import 'package:cloud_firestore/cloud_firestore.dart';

class ClubModel {
  final String docId;
  final String name;
  final String category;
  final String description;
  final String aboutClub;
  final String compulsory;
  final String forwho;
  final String activity;

  ClubModel({
    required this.docId,
    required this.name,
    required this.category,
    required this.description,
    required this.aboutClub,
    required this.compulsory,
    required this.forwho,
    required this.activity,
  });
  factory ClubModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return ClubModel(
      docId: data['docId'],
      name: data['name'],
      category: data['category'],
      description: data['description'],
      aboutClub: data['aboutClub'],
      compulsory: data['compulsory'],
      forwho: data['forwho'],
      activity: data['activity'],
    );
  }
}

class ClubRepository {
  final db = FirebaseFirestore.instance;
  Future<ClubModel?> readClub(docId) async {
    try {
      final snapshot = await db.collection('club').doc(docId).get();

      final clubData = ClubModel.fromSnapshot(snapshot);

      return clubData;
    } catch (e) {
      print('Error reading clubs: $e');
      return null;
    }
  }

  Future<List<ClubModel>> readAllClubs() async {
    try {
      final snapshot = await db.collection('club').get();

      final clubListData = await Future.wait(snapshot.docs.map((e) async {
        return await ClubModel.fromSnapshot(e);
      }));

      return clubListData;
    } catch (e) {
      print('Error reading products: $e');
      return [];
    }
  }
}
