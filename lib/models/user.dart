import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class User {
  final String uid;
  final String username;
  final String email;
  final String passion;
  final String photoUrl;
  final List friends;

  User({
    required this.uid,
    required this.username,
    required this.email,
    required this.passion,
    required this.photoUrl,
    required this.friends,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'username': username,
        'email': email,
        'passion': passion,
        'photoUrl': photoUrl,
        'friends': [],
      };

  static User fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;

    return User(
        uid: snap['uid'],
        username: snap['username'],
        email: snap['email'],
        passion: snap['passion'],
        photoUrl: snap['photoUrl'],
        friends: snap['friends']);
  }
}
