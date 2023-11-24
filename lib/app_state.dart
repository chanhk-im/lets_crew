import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AppState {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('user');

  Future<User?> handleGoogleSignIn() async {
    try {
      // Google Sign-In
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Firebase Authentication
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      // Check if the user already exists in Firestore
      final DocumentSnapshot userSnapshot =
          await _usersCollection.doc(user?.uid).get();

      if (!userSnapshot.exists) {
        // User does not exist in Firestore, add them
        await _usersCollection.doc(user?.uid).set({
          'uid': user?.uid,
          'name': user?.displayName,
          'email': user?.email,
          'role': false,
        });
      }

      return user;
    } catch (e) {
      print('Google Sign-In Error: $e');
      return null;
    }
  }

  Future<User?> anonymousLogin() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      print("Signed in with temporary account.");
      final User? user = userCredential.user;
      final DocumentSnapshot userSnapshot =
          await _usersCollection.doc(user?.uid).get();
      if (!userSnapshot.exists) {
        // User does not exist in Firestore, add them
        await _usersCollection.doc(user?.uid).set({
          'uid': user?.uid,
          'role': false,
        });
      }
      return user;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "operation-not-allowed":
          print("Anonymous auth hasn't been enabled for this project.");
          break;
        default:
          print("Unknown error.");
      }
      return null;
    }
  }
}
