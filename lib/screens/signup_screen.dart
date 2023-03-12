import 'dart:math';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frincle_v2/screens/login_screen.dart';
import 'package:frincle_v2/service/auth_service.dart';
import 'package:frincle_v2/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

import '../responsive/mobile_screenLayout.dart';
import '../responsive/responsive.dart';
import '../responsive/web_screenlayout.dart';
import '../widgets/text_form_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passionController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  Uint8List? _image;
  final auth = FirebaseAuth.instance;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passionController.dispose();
    _passionController.dispose();
    _nameController.dispose();
  }

  selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  void signup() async {
    setState(() {
      isLoading = true;
    });

    String res = await AuthService().signUpUser(
      username: _nameController.text,
      email: _emailController.text,
      password: _passionController.text,
      passion: _passionController.text,
      file: _image!,
    );
    if (res != 'success') {
      setState(() {
        isLoading = false;
      });
      showSnackabar(context, "check your credentials");
    } else {
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
              webScreenLayout: WebScreenLayout(),
              mobileSceenLayout: MobileScreenLayout()),
        ),
      );
    }
  }

  void navigateToLogin() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.all(15),
        child: Column(children: [
          Flexible(
            child: Container(),
            flex: 2,
          ),
          Text(
            'frincle',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 35,
                color: Theme.of(context).primaryColor),
          ),
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Explore, Enjoy, and follow your passion",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Stack(children: [
            _image != null
                ? CircleAvatar(
                    backgroundImage: MemoryImage(_image!),
                    radius: 64,
                  )
                : const CircleAvatar(
                    backgroundImage: null,
                    backgroundColor: Color.fromARGB(255, 177, 176, 176),
                    radius: 64,
                  ),
            Positioned(
              bottom: 30,
              left: 30,
              child: IconButton(
                icon: const Icon(Icons.add_a_photo_rounded),
                onPressed: selectImage,
                color: Theme.of(context).primaryColor,
                iconSize: 50,
              ),
            )
          ]),
          const SizedBox(
            height: 20,
          ),
          TextFieldInput(
            hintText: "enter your Name",
            controller: _nameController,
            textInputType: TextInputType.text,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFieldInput(
              hintText: "enter your Email",
              controller: _emailController,
              textInputType: TextInputType.emailAddress),
          const SizedBox(
            height: 20,
          ),
          TextFieldInput(
            hintText: "enter your Passion",
            controller: _passionController,
            textInputType: TextInputType.text,
          ),
          const SizedBox(
            height: 20,
          ),
          TextFieldInput(
            hintText: "enter your Password",
            controller: _passwordController,
            textInputType: TextInputType.text,
            isPass: true,
          ),
          const SizedBox(
            height: 25,
          ),
          InkWell(
            onTap: signup,
            child: Container(
              height: 50,
              width: double.infinity,
              child: !isLoading
                  ? const Text(
                      'SignUp',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.white),
                    )
                  : const CircularProgressIndicator(
                      color: Colors.white,
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
          Flexible(
            child: Container(),
            flex: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: const Text(
                  'Already have an account? ',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              InkWell(
                onTap: navigateToLogin,
                child: Container(
                  child: const Text(
                    'LogIn',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blue),
                  ),
                ),
              )
            ],
          ),
        ]),
      )),
    );
    ;
  }
}
