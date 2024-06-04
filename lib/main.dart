import 'package:campus_olx/firebase_options.dart';
import 'package:campus_olx/screens/authen.dart';
import 'package:campus_olx/screens/detail_screen.dart';
import 'package:campus_olx/screens/home_screen.dart';
import 'package:campus_olx/screens/splash_screen.dart';
import 'package:campus_olx/screens/upload_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // brightness: Brightness.light, primaryColor: AppColors.bgColor),
          brightness: Brightness.light,
          primaryColor: Colors.white,
          textTheme: TextTheme(
              bodyLarge: TextStyle(
                  color: const Color.fromARGB(255, 14, 13, 13), fontSize: 24),
              bodyMedium: TextStyle(
                  color: const Color.fromARGB(255, 10, 9, 9), fontSize: 20)),
          colorScheme: ColorScheme.fromSeed(
                  seedColor: Colors.deepPurple, brightness: Brightness.light)
              .copyWith(surface: Colors.black),
          // fontFamily: GoogleFonts.ptSans().fontFamily,
          useMaterial3: true),
      home: SplashScreen(),
    );
  }
}
