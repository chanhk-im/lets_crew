import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lets_crew/firebase_options.dart';
import 'package:lets_crew/model/club_model.dart';

class AppState extends ChangeNotifier {
  AppState() {
    init();
  }
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('user');

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  StreamSubscription<QuerySnapshot>? _clubSubscription;
  List<ClubModel> _clubs = [];
  List<ClubModel> get clubs => _clubs;

  Future<void> init() async {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
        print("logged!");
        _clubSubscription = FirebaseFirestore.instance.collection('club').snapshots().listen((event) {
          _clubs = [];
          for (final document in event.docs) {
            _clubs.add(ClubModel.fromSnapshot(document));
          }
          notifyListeners();
        });
      } else {
        _loggedIn = false;
        _clubs = [];
      }
      notifyListeners();
    });
  }

  Future<void> likeProducts(ClubModel club) async {
    if (club.likes.contains(_auth.currentUser!.uid)) {
      club.likes.remove(_auth.currentUser!.uid);
    } else {
      club.likes.add(_auth.currentUser!.uid);
    }
    notifyListeners();
    return await FirebaseFirestore.instance.collection('club').doc(club.docId).update(<String, dynamic>{
      'likes': club.likes,
    });
  }

  Future<User?> handleGoogleSignIn() async {
    try {
      // Google Sign-In
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      // Firebase Authentication
      final UserCredential userCredential = await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      // Check if the user already exists in Firestore
      final DocumentSnapshot userSnapshot = await _usersCollection.doc(user?.uid).get();

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
      final DocumentSnapshot userSnapshot = await _usersCollection.doc(user?.uid).get();
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
