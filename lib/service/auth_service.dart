import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:frincle_v2/service/Storage_service.dart';
import '../models/user.dart' as model;

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // getting the user details and storing in the providers

  Future<model.User> getUserDetails() async {
    User currentUser = await _firebaseAuth.currentUser!;

    DocumentSnapshot snapshot =
        await _firebaseFirestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snapshot);
  }
  // Sigin up the user

  Future<String> signUpUser({
    required String username,
    required String email,
    required String password,
    required String passion,
    required Uint8List file,
  }) async {
    String res = 'User is not signed in';
    try {
      UserCredential cred = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      final photoUrl =
          await StorageMethods().StoreUserImages("profilepics", file, false);

      model.User user = model.User(
          uid: cred.user!.uid,
          username: username,
          email: email,
          passion: passion,
          photoUrl: photoUrl,
          friends: []);

      await _firebaseFirestore
          .collection("users")
          .doc(cred.user!.uid)
          .set(user.toJson());
      return res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }

  // login in the user

  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = 'some error occured';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        res = 'success';
      } else {
        res = 'Please enter all the fields correctly';
      }
    } on FirebaseAuthException catch (e) {
      e.message.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
