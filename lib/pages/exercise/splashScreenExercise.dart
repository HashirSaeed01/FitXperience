import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreenExercise extends StatefulWidget {
  @override
  _SplashScreenExerciseState createState() => _SplashScreenExerciseState();
}

class _SplashScreenExerciseState extends State<SplashScreenExercise> {
  @override
  void initState() {
    super.initState();
    // Navigate away after 5 seconds
    Timer(Duration(seconds: 5), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Replace this with your splash screen UI
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 200,
              height: 200,
              child: Image.asset(
                  'public/assets/images/splashScreenExercise.jpg',
                  fit: BoxFit.cover),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Center(
                child: Text(
                  'EXERCISE ADDED!',
                  style: GoogleFonts.montserrat(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 30)),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
