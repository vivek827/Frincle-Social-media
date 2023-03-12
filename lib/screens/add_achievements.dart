import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frincle_v2/provider/user_provider.dart';
import 'package:frincle_v2/service/auth_service.dart';
import 'package:frincle_v2/service/firebase_methods.dart';
import 'package:frincle_v2/utils/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../provider/user_provider.dart';
import '../widgets/text_form_field.dart';

class AchievementsTab extends StatefulWidget {
  const AchievementsTab({super.key});

  @override
  State<AchievementsTab> createState() => _AchievementsTabState();
}

class _AchievementsTabState extends State<AchievementsTab> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController teamController = TextEditingController();
  Uint8List? _images;
  bool _isLoading = false;

  final FirebaseMethods _firebaseMethods = FirebaseMethods();

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
    teamController.dispose();
  }

  void _selectImage() async {
    Uint8List photo = await pickImage(ImageSource.gallery);
    setState(() {
      _images = photo;
    });
  }

  void addpost(String uid, String username, String photourl) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String res = await _firebaseMethods.uploadPost(
        uid,
        username,
        _images!,
        titleController.text,
        descriptionController.text,
        photourl,
        teamController.text,
      );

      if (res == 'success') {
        setState(() {
          _isLoading = false;
        });
        showSnackabar(context, "Achievement added...!");
      } else {
        showSnackabar(context, "please try again");
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      showSnackabar(context, e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final UserProvider userProvider = Provider.of<UserProvider>(context);
    return SingleChildScrollView(
        child: Container(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Add your achievements",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: _selectImage,
            child: Container(
              height: 200,
              width: 200,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: _images != null
                  ? Image.memory(_images!)
                  : Icon(
                      Icons.upload,
                      size: 30,
                    ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFieldInput(
            hintText: "title",
            controller: titleController,
            textInputType: TextInputType.text,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFieldInput(
            hintText: 'description',
            controller: descriptionController,
            textInputType: TextInputType.text,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFieldInput(
            hintText: 'add team mates',
            controller: teamController,
            textInputType: TextInputType.text,
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () => addpost(userProvider.getUser.uid,
                userProvider.getUser.username, userProvider.getUser.photoUrl),
            child: Container(
              height: 50,
              width: double.infinity,
              child: _isLoading
                  ? const CircularProgressIndicator(
                      color: Colors.white,
                    )
                  : const Text(
                      'Add',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    ),
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: ShapeDecoration(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4))),
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ]),
      ),
    ));
  }
}
