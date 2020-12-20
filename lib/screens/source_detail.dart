import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justnews/bloc/get_source_news_bloc.dart';
import 'package:justnews/bloc/get_top_headlines_bloc.dart';
import 'package:justnews/elements/error_element.dart';
import 'package:justnews/elements/loader_element.dart';
import 'package:justnews/model/article.dart';
import 'package:justnews/model/article_response.dart';
import 'package:justnews/model/source.dart';
import 'package:justnews/screens/tabs/news_details.dart';
import 'package:justnews/style/theme.dart' as Style;
import 'package:timeago/timeago.dart' as timeago;

class SourceDetail extends StatefulWidget {
  final SourceModel source;

  SourceDetail({Key key, @required this.source}) : super(key: key);

  @override
  _SourceDetailState createState() => _SourceDetailState(source);
}

class _SourceDetailState extends State<SourceDetail> {
  final SourceModel source;

  _SourceDetailState(this.source);

  @override
  void initState() {
    super.initState();
    getSourceNewsBloc.getSourceNews(source.id);
  }

  @override
  void dispose() {
    super.dispose();
    getSourceNewsBloc.drainStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          child: AppBar(
            elevation: 0,
            backgroundColor: Style.Colors.mainColor,
            title: Text(""),
          ),
          preferredSize: Size.fromHeight(40)),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
            color: Style.Colors.mainColor,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Hero(
                    tag: source.id,
                    child: SizedBox(
                      height: 80,
                      width: 80,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 2, color: Colors.white),
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(
                                    "assets/logos/${source.id}.png"))),
                      ),
                    )),
                SizedBox(
                  height: 5,
                ),
                Text(
                  source.name,
                  style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  source.description,
                  style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder<ArticleResponse>(
              stream: getSourceNewsBloc.subject.stream,
              builder: (context, AsyncSnapshot<ArticleResponse> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data.error != null &&
                      snapshot.data.error.length < 0) {
                    return buildErrorWidget(snapshot.error);
                  }
                  return _buildSourceNews(snapshot.data);
                } else if (snapshot.hasError) {
                  return buildErrorWidget(snapshot.error);
                } else {
                  return buildLoadingWidget();
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSourceNews(ArticleResponse data) {
    List<ArticleModel> articles = data.articles;
    if (articles.length == 0) {
      return Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text("No Articles")],
        ),
      );
    } else {
      return ListView.builder(
          itemCount: articles.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NewsDetails(
                              article: articles[index],
                            )));
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Colors.grey[200], width: 1)),
                  color: Colors.white,
                ),
                height: 150,
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width * 3 / 5,
                      child: Column(
                        children: [
                          Text(
                            articles[index].title,
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black),
                          ),
                          Expanded(
                              child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Row(
                              children: [
                                Text(
                                  timeAgo(
                                    DateTime.parse(articles[index].date),
                                  ),
                                  style: GoogleFonts.lato(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10),
                                )
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(right: 10.0),
                        width: MediaQuery.of(context).size.width * 2 / 5,
                        height: 130,
                        child: FadeInImage.assetNetwork(
                            alignment: Alignment.topCenter,
                            placeholder: 'assets/images/placeholder.jpg',
                            image: articles[index].img == null
                                ? "http://to-let.com.bd/operator/images/noimage.png"
                                : articles[index].img,
                            fit: BoxFit.fitHeight,
                            width: double.maxFinite,
                            height:
                                MediaQuery.of(context).size.height * 1 / 3)),
                  ],
                ),
              ),
            );
          });
    }
  }

  String timeAgo(DateTime date) {
    return timeago.format(date, allowFromNow: true, locale: 'en');
  }
}
