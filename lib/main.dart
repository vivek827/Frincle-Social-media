import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:frincle_v2/provider/user_provider.dart';
import 'package:frincle_v2/responsive/mobile_screenLayout.dart';
import 'package:frincle_v2/responsive/responsive.dart';
import 'package:frincle_v2/responsive/web_screenlayout.dart';
import 'package:frincle_v2/screens/login_screen.dart';
import 'package:frincle_v2/screens/signup_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyDAZP0MYsjU5YERSm7w94Bm9PjqPYG7KnE",
        appId: "frinclev2.firebaseapp.com",
        messagingSenderId: "54673147792",
        projectId: "frinclev2",
        storageBucket: "frinclev2.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primaryColor: Color.fromARGB(255, 110, 2, 105),
              textTheme:
                  GoogleFonts.rubikTextTheme(Theme.of(context).textTheme)),
          home: StreamBuilder(
            stream: FirebaseAuth.instance.userChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return const ResponsiveLayout(
                      webScreenLayout: WebScreenLayout(),
                      mobileSceenLayout: MobileScreenLayout());
                } else if (snapshot.hasError) {
                  return const Center(
                    child: Text("Internal error happened"),
                  );
                }
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                );
              }
              return SignUpScreen();
            },
          )),
    );
  }
}
