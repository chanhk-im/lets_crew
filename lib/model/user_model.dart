import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String? email;
  final String? name;
  final bool role;

  UserModel({
    required this.uid,
    this.email,
    this.name,
    required this.role,
  });
  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      uid: data['uid'],
      name: data['name'],
      email: data['email'],
      role: data['role'],
    );
  }
}

class UserRepository {
  final db = FirebaseFirestore.instance;
  Future<UserModel?> readUser(uid) async {
    if (uid == null) return null;
    try {
      final snapshot = await db.collection('user').doc(uid).get();

      final userData = await UserModel.fromSnapshot(snapshot);

      return userData;
    } catch (e) {
      print('Error reading products: $e');
      return null;
    }
  }
}
