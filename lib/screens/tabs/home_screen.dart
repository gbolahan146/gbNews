import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justnews/widgets/headline_slider.dart';
import 'package:justnews/widgets/hot_btc_news.dart';
import 'package:justnews/widgets/hot_ent_news.dart';
import 'package:justnews/widgets/hot_news.dart';
import 'package:justnews/widgets/top_channels.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        HeadlineSliderWidget(),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "Top Channels",
            style: GoogleFonts.lato(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
        TopChannels(),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            "Hot news",
            style: GoogleFonts.lato(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
        HotNews(),
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: RichText(
            text: TextSpan(
                text: "Bitcoin news",
                style: GoogleFonts.lato(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17),
                children: [
                  TextSpan(
                      text: " ₿",
                      style: GoogleFonts.ubuntu(color: Color(0xffFFD700)))
                ]),
          ),
        ),
        Divider(
          color: Colors.grey,
        ),
        BtcHotNews(),
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: RichText(
            text: TextSpan(
              text: " Entertainment news",
              style: GoogleFonts.lato(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17),
            ),
          ),
        ),
        Divider(
          color: Colors.grey,
        ),
        HotEntNews(),
      ],
    );
  }
}
