import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:frincle_v2/service/auth_service.dart';
import 'package:frincle_v2/utils/utils.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> StoreUserImages(
    String childName,
    Uint8List file,
    bool ispost,
  ) async {
    Reference ref = await _firebaseStorage
        .ref()
        .child(childName)
        .child(_auth.currentUser!.uid);

    if (ispost) {
      String id = Uuid().v1();
      ref.child(id);
    }

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;

    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}
