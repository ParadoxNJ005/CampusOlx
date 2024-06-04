import 'dart:math';

import 'package:campus_olx/screens/authen.dart';
import 'package:campus_olx/screens/home_screen.dart';
import 'package:campus_olx/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Initialize Firebase
    Firebase.initializeApp().then((_) {
      Timer(Duration(seconds: 3), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => AuthenticationWrapper(),
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 29, 14, 125),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 500, // specify the width you want
                height: 200, // specify the height you want
                child: Lottie.asset("assets/olx.json"),
              ),
              SizedBox(
                height: 100,
              ),
              Container(
                child: Text(
                  "Campus OLX",
                  style: TextStyle(
                      fontFamily: GoogleFonts.gluten().fontFamily,
                      fontSize: 50),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          print("wait");
          return CircularProgressIndicator();
        } else if (snapshot.hasData) {
          print("home");
          return BottomNavBar();
        } else {
          print("auth");
          return AuthenScreen();
        }
      },
    );
  }
}
