import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:frincle_v2/screens/signup_screen.dart';
import 'package:frincle_v2/service/auth_service.dart';
import 'package:frincle_v2/utils/utils.dart';
import 'package:frincle_v2/widgets/text_form_field.dart';

import '../responsive/mobile_screenLayout.dart';
import '../responsive/responsive.dart';
import '../responsive/web_screenlayout.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isloading = false;
  final _auth = FirebaseAuth.instance;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void logintheUser() async {
    setState(() {
      isloading = true;
    });
    String res = await AuthService().loginUser(
        email: _emailController.text, password: _passwordController.text);

    if (res == 'success') {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
              webScreenLayout: WebScreenLayout(),
              mobileSceenLayout: MobileScreenLayout()),
        ),
      );
    } else {
      showSnackabar(context, "Email or password is wrong");
    }
    setState(() {
      isloading = false;
    });
  }

  void navigateToSignup() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
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
            "Welcome Back...!!!",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 64,
          ),
          TextFieldInput(
              hintText: "enter yout Email",
              controller: _emailController,
              textInputType: TextInputType.emailAddress),
          const SizedBox(
            height: 20,
          ),
          TextFieldInput(
            hintText: "enter yout Password",
            controller: _passwordController,
            textInputType: TextInputType.text,
            isPass: true,
          ),
          const SizedBox(
            height: 25,
          ),
          InkWell(
            onTap: logintheUser,
            child: Container(
              height: 50,
              width: double.infinity,
              child: !isloading
                  ? const Text(
                      'login',
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
                  'Don\'t have an account? ',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
              InkWell(
                onTap: navigateToSignup,
                child: Container(
                  child: const Text(
                    'SignUp',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ]),
      )),
    );
  }
}
