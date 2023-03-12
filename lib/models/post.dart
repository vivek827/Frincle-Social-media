import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Post {
  final String uid;
  final String username;
  final String description;
  final String photoUrl;
  final String proImage;
  final String postId;
  final String team;
  final List likes;

  Post({
    required this.uid,
    required this.username,
    required this.description,
    required this.photoUrl,
    required this.proImage,
    required this.postId,
    required this.team,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'username': username,
        'description': description,
        'postId': postId,
        'photoUrl': photoUrl,
        'proImage': proImage,
        'team': team,
        'likes': [],
      };

  static Post fromSnap(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;

    return Post(
        uid: snap['uid'],
        username: snap['username'],
        description: snap['description'],
        postId: snap['postId'],
        photoUrl: snap['photoUrl'],
        proImage: snap['proImage'],
        team: snap['team'],
        likes: snap['likes']);
  }
}
