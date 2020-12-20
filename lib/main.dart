import 'package:flutter/material.dart';
import 'package:justnews/screens/splashscreen1.dart';
import 'package:justnews/screens/splashscreen1.dart';
import 'package:justnews/screens/main_screen.dart';
import 'package:justnews/screens/onboarding.dart';
import 'package:justnews/screens/splashscreen1.dart';
import 'package:justnews/screens/tabs/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';


int initScreen;
Future main() async{
  runApp(MyApp());

  SharedPreferences prefs = await SharedPreferences.getInstance();

  // ignore: await_only_futures
  initScreen = await prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
        return MaterialAPP();
  }
}


class MaterialAPP extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Just News',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: initScreen == 0 || initScreen == null
          ? SplashScreen1() : SplashScreen(),
    );
  }
}