import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justnews/screens/onboarding.dart';
import 'package:lottie/lottie.dart';

import '../main_screen.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    startTimer();
  }

  startTimer() async {
    var duration = Duration(seconds: 5);

    return new Timer(duration, () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) => MainScreen()));
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColorLight,
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 300,
                    height: 300,
                    child: Lottie.asset('assets/images/news1.json', width: 70)
                    ),
                Text(
                  "Just News",
                  style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w600, )
                )
              ],
            ),
          ),
        ));
  }
}
