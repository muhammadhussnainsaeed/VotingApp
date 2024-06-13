import 'package:flutter/material.dart';

import 'WelcomeScreen.dart';

class VotingApp extends StatelessWidget {
  const VotingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.teal, // Change the primary color to teal
        hintColor: Colors.tealAccent, // Change the accent color to tealAccent
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal, // Change the background color of the ElevatedButton to teal
          ),
        ),
      ),
      home: WelcomeScreen(),
    );
  }
}