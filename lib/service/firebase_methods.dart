import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:frincle_v2/service/Storage_service.dart';
import '../models/post.dart';
import 'package:uuid/uuid.dart';

class FirebaseMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> uploadPost(
    String uid,
    String username,
    Uint8List file,
    String title,
    String description,
    String proImage,
    String team,
  ) async {
    String res = 'Oops...! something went wrong';
    try {
      final photoUrl = await StorageMethods().StoreUserImages(
        'posts',
        file,
        true,
      );
      String postId = const Uuid().v1();
      Post post = Post(
        uid: uid,
        username: username,
        description: description,
        photoUrl: photoUrl,
        proImage: proImage,
        postId: postId,
        team: team,
        likes: [],
      );

      _firestore.collection('posts').doc(postId).set(
            post.toJson(),
          );
      res = 'success';
    } catch (e) {
      res = e.toString();
    }
    return res;
  }
}
