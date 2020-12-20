import 'dart:math';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justnews/model/article.dart';
import 'package:justnews/style/theme.dart' as Style;
import 'package:like_button/like_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

const double buttonSize = 30.0;

class NewsDetails extends StatefulWidget {
  final ArticleModel article;

  const NewsDetails({Key key, @required this.article}) : super(key: key);

  @override
  _NewsDetailsState createState() => _NewsDetailsState(article);
}

Random random = new Random();
final int likeCount = random.nextInt(100) + 50;

class _NewsDetailsState extends State<NewsDetails> {
  final GlobalKey<LikeButtonState> _globalKey = GlobalKey<LikeButtonState>();
  final ArticleModel article;

  _NewsDetailsState(this.article);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GestureDetector(
        onTap: () {
          launch(article.url);
        },
        child: Container(
          color: Style.Colors.mainColor,
          width: MediaQuery.of(context).size.width,
          height: 48,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Read More",
                style: GoogleFonts.lato(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Style.Colors.mainColor,
        title: Text(
          article.title,
          style: GoogleFonts.lato(
              fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child:  FadeInImage.assetNetwork(
                placeholder: 'assets/images/placeholder.jpg',
                image: article.img != null? article.img : "assets/images/logo.png",
                fit: BoxFit.cover),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  article.date.substring(0, 10),
                  style: GoogleFonts.lato(
                      color: Style.Colors.mainColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  article.title,
                  style: GoogleFonts.lato(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black),
                ),
                SizedBox(
                  height: 10,
                ),
                Column(
                  children: [
                    Html(data: article.content == null ? "" : article.content),
                    Row(
                      children: [
                        LikeButton(
                          likeBuilder: (bool isLiked) {
                            return Icon(
                              Icons.thumb_up,
                              color: isLiked ? Colors.pink : Colors.grey,
                              size: buttonSize,
                            );
                          },
                          size: buttonSize,
                          likeCount: likeCount,
                          key: _globalKey,
                          countBuilder: (int count, bool isLiked, String text) {
                            final ColorSwatch<int> color =
                                isLiked ? Colors.pinkAccent : Colors.grey;
                            Widget result;
                            if (count == 0) {
                              result = Text(
                                'Good',
                                style: GoogleFonts.lato(color: color),
                              );
                            } else
                              result = Text(
                                count >= 1000
                                    ? (count / 1000.0).toStringAsFixed(1) + 'k'
                                    : text,
                                style: GoogleFonts.lato(color: color),
                              );
                            return result;
                          },
                          likeCountAnimationType: likeCount < 1000
                              ? LikeCountAnimationType.part
                              : LikeCountAnimationType.none,
                          likeCountPadding: const EdgeInsets.only(left: 15.0),
                          onTap: onLikeButtonTapped,
                        ),
                        IconButton(icon: Icon(Icons.share), onPressed: share)
                      ],
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    bool liked = false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: await_only_futures
    liked = !liked;
    print(liked);
    // ignore: await_only_futures
    await prefs.setBool('liked', true);
    return !isLiked;
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: article.title,
        text: article.content,
        linkUrl: article.url,
        chooserTitle: ' Chooser Title');
  }
}
