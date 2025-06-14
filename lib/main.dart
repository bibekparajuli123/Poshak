import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poshak_shopping_app/screens/get_started_screen.dart';
import 'package:poshak_shopping_app/screens/home_screen.dart';
import 'package:poshak_shopping_app/screens/sign_in_screen.dart';
import 'package:poshak_shopping_app/screens/sign_up_screen.dart';

void main() {
  runApp(PoshakApp());
}

class PoshakApp extends StatelessWidget {
  const PoshakApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poshak',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF800000),
        scaffoldBackgroundColor: const Color(0xFFFFF8F3),
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: true,
      ),
      initialRoute: '/', // Start with Get Started screen
      routes: {
        '/': (context) => GetStartedScreen(),
        '/signup': (context) => SignUpScreen(),
        '/signin': (context) => SignInScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}