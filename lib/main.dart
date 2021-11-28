// ignore_for_file: prefer_const_constructors

import 'package:aura_flutter/pageroutes.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:aura_flutter/views/register.dart';
import 'package:aura_flutter/views/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuraSplash(),
      title: 'Aura',
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity),
    );
  }
}

class AuraSplash extends StatelessWidget {
  const AuraSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? result = FirebaseAuth.instance.currentUser;
    return SplashScreen(
      backgroundColor: Colors.grey.shade50,
      styleTextUnderTheLoader: TextStyle(),
      loadingText: Text(""),
      loadingTextPadding: EdgeInsets.all(0),
      useLoader: true,
      navigateAfterSeconds: result != null ? PageRoutes() : RegisterScreen(),
      seconds: 4,
      title: Text(
        "Welcome to Aura",
        style: GoogleFonts.nunitoSans(
          fontWeight: FontWeight.bold,
          fontSize: 24.0,
        ),
      ),
      image: Image.asset(
        "assets/aura.png",
        fit: BoxFit.contain,
        height: 45.0,
        width: 45.0,
      ),
      loaderColor: Color(0xff9f2940),
    );
  }
}
