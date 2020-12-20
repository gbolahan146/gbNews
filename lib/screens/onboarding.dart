import 'package:concentric_transition/concentric_transition.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justnews/screens/main_screen.dart';

import 'main_screen.dart';

class PageData {
  final String title;
  final IconData icon;
  final Color bgColor;
  final Color textColor;

  PageData({
    this.title,
    this.icon,
    this.bgColor = Colors.white,
    this.textColor = Colors.black,
  });
}

class OnboardingExample extends StatelessWidget {
  final List<PageData> pages = [
    PageData(
      icon: Icons.blur_on,
      title: "Latest news\n and updates",
      textColor: Colors.white,
      bgColor: Color(0xff9f2b00),
    ),
    PageData(
      icon: EvaIcons.messageCircle,
      title: "Search for News",
      bgColor: Color(0xffd37506),
      textColor: Colors.white
    ),
    PageData(
      icon: Icons.bubble_chart,
      title: "Local news\n stories",
      bgColor: Color(0xffd3d3cb),
      textColor: Colors.white,
    ),
    PageData(
      icon: Icons.bubble_chart,
      title: "Get Started...",
      bgColor: Color(0xffada7a7),
      textColor: Colors.white,
    ),
  ];

  List<Color> get colors => pages.map((p) => p.bgColor).toList();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ConcentricPageView(
          colors: colors,
          opacityFactor: 1.0,
          scaleFactor: 0.0,
          radius: 500,

          curve: Curves.ease,
          duration: Duration(seconds: 2),
          verticalPosition: 0.7,
          direction: Axis.vertical,
//          itemCount: pages.length,
//          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (index, value) {
            PageData page = pages[index % pages.length];
            // For example scale or transform some widget by [value] param
            //            double scale = (1 - (value.abs() * 0.4)).clamp(0.0, 1.0);
            return Container(
              child: Theme(
                data: ThemeData(
                  textTheme: TextTheme(
                    title: GoogleFonts.lato(
                      color: page.textColor,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.0,
                      fontSize: 36,
                    ),
                    subtitle: GoogleFonts.lato(
                      color: page.textColor,
                      fontWeight: FontWeight.w300,
                      fontSize: 18,
                    ),
                  ),
                ),
                child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MainScreen()));
                    },
                    child: PageCard(page: page)),
              ),
            );
          },
        ),
      ),
    );
  }
}

class PageCard extends StatelessWidget {
  final PageData page;

  const PageCard({
    Key key,
    @required this.page,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 30.0,
      ),
      child: Column(
//        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildPicture(context),
          SizedBox(height: 30),
          _buildText(context),
        ],
      ),
    );
  }

  Widget _buildText(BuildContext context) {
    return Text(
      page.title,
      style: Theme.of(context).textTheme.title,
      textAlign: TextAlign.center,
    );
  }

  Widget _buildPicture(
    BuildContext context, {
    double size = 190,
    double iconSize = 170,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(60.0)),
        color: page.bgColor
//            .withBlue(page.bgColor.blue - 40)
            .withGreen(page.bgColor.green + 20)
            .withRed(page.bgColor.red - 100)
            .withAlpha(90),
      ),
      margin: EdgeInsets.only(
        top: 140,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Positioned.fill(
            child: RotatedBox(
              quarterTurns: 2,
              child: Icon(
                page.icon,
                size: iconSize + 20,
                // color: page.bgColor
                //     .withBlue(page.bgColor.blue - 10)
                //     .withGreen(220),
              ),
            ),
            right: -5,
            bottom: -5,
          ),
          Positioned.fill(
            child: RotatedBox(
              quarterTurns: 5,
              child: Icon(
                page.icon,
                size: iconSize + 20,
                color: page.bgColor.withGreen(66).withRed(77),
              ),
            ),
          ),
          Icon(
            page.icon,
            size: iconSize,
            color: page.bgColor.withRed(111).withGreen(220),
          ),
        ],
      ),
    );
  }
}
