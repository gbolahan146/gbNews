import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:justnews/bloc/get_sources_bloc.dart';
import 'package:justnews/elements/error_element.dart';
import 'package:justnews/elements/loader_element.dart';
import 'package:justnews/model/source.dart';
import 'package:justnews/model/source_response.dart';
import 'package:justnews/screens/source_detail.dart';

class SourceScreen extends StatefulWidget {
  @override
  _SourceScreenState createState() => _SourceScreenState();
}

class _SourceScreenState extends State<SourceScreen> {
  @override
  void initState() {
    super.initState();
    getSourcesBloc..getSources();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SourceResponse>(
      stream: getSourcesBloc.subject.stream,
      builder: (context, AsyncSnapshot<SourceResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length < 0) {
            return buildErrorWidget(snapshot.error);
          }
          return _buildSources(snapshot.data);
        } else if (snapshot.hasError) {
          return buildErrorWidget(snapshot.error);
        } else {
          return buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildSources(SourceResponse data) {
    List<SourceModel> sources = data.sources;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, childAspectRatio: 0.86),
      itemCount: sources.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(left: 5, right: 5, top: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          SourceDetail(source: sources[index])));
            },
            child: Container(
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey[100],
                        blurRadius: 5,
                        spreadRadius: 1,
                        offset: Offset(1, 1))
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                      tag: sources[index].id,
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/logos/${sources[index].id}.png",
                                ),
                                fit: BoxFit.cover)),
                      )),
                  Container(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 15, bottom: 15),
                    child: Text(
                      sources[index].name,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style:
                          GoogleFonts.lato(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
