import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:justnews/model/article_response.dart';
import 'package:justnews/model/source_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsRepository {
  static String mainUrl = "https://newsapi.org/v2/";
  String apiKey = DotEnv().env['apiKey'];
  final String apiKey2 = DotEnv().env['apiKey2'];

  final List apiKeysList = [DotEnv().env['apiKey'],DotEnv().env['apiKey2']];
  String errResponse;
  String exhaustedError = 'apiKeyExhausted';


  final Dio _dio = Dio();

  var getSourcesUrl = "$mainUrl/sources";
  var getTopHeadlinesUrl = "$mainUrl/top-headlines";
  var everythingUrl = "$mainUrl/everything";

  //TODO: This is where I implemented it.

  ///@index is the index in the API KEYS array to access.
  ///The count is to keep count of number of times the network is called.
  ///and is used to exit the recursion.
  Future<SourceResponse> getSources(int index,int count) async {
    if(count >= apiKeysList.length ) {
      //I don't know the preferred response to pass here, just passing this one.
      return SourceResponse.withError(exhaustedError);
    }

    if(index == apiKeysList.length) {
      index = 0;
    }
    var params = {
      "apiKey": apiKeysList[index],
      "language": "en",
    };
    try {
      Response response = await _dio.get(getSourcesUrl, queryParameters: params);
      if(response.statusCode == 200) {
          //reshuffle the list.
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('ValidApiKey', index);
      }
      return SourceResponse.fromJson(response.data);
    } catch (error) {
      errResponse = error.response.data["code"].toString();
      if (errResponse == exhaustedError) {
        getSources(++index,++count);
      }
      return SourceResponse.withError(error);
    }
  }



  Future<SourceResponse> getNgSources() async {
    var params = {"apiKey": apiKey, "language": "en", "country": "ng"};
    try {
      Response response =
          await _dio.get(getSourcesUrl, queryParameters: params);
      return SourceResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      errResponse = error.response.data["code"].toString();
      if (errResponse == exhaustedError) {
        apiKey = apiKey2;
      }
      print("Exception occurred: $error stacktrace: $stacktrace");
      return SourceResponse.withError(error.toString());
    }
  }

  Future<ArticleResponse> getTopHeadlines() async {
    var params = {"apiKey": apiKey, "country": "us"};
    try {
      Response response =
          await _dio.get(getTopHeadlinesUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      errResponse = error.response.data["code"].toString();
      if (errResponse == exhaustedError) {
        apiKey = apiKey2;
      }
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ArticleResponse.withError(error.toString());
    }
  }

  Future<ArticleResponse> getSourceNews(String sourceId) async {
    var params = {"apiKey": apiKey, "sources": sourceId};
    try {
      Response response =
          await _dio.get(getTopHeadlinesUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      errResponse = error.response.data["code"].toString();
      if (errResponse == exhaustedError) {
        apiKey = apiKey2;
      }
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ArticleResponse.withError(error.toString());
    }
  }

  Future<ArticleResponse> search(String searchValue) async {
    var params = {"apiKey": apiKey, "q": searchValue};
    try {
      Response response =
          await _dio.get(getTopHeadlinesUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      errResponse = error.response.data["code"].toString();
      if (errResponse == exhaustedError) {
        apiKey = apiKey2;
      }
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ArticleResponse.withError(error.toString());
    }
  }

  Future<ArticleResponse> getHotNews() async {
    var params = {
      "apiKey": apiKey,
      "q": "entertainment",
      "sortBy": "popularity"
    };
    try {
      Response response =
          await _dio.get(everythingUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      errResponse = error.response.data["code"].toString();
      if (errResponse == exhaustedError) {
        apiKey = apiKey2;
      }
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ArticleResponse.withError(error.toString());
    }
  }

  Future<ArticleResponse> getBtcHotNews() async {
    var params = {"apiKey": apiKey, "q": "btc", "sortBy": "popularity"};
    try {
      Response response =
          await _dio.get(everythingUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      errResponse = error.response.data["code"].toString();
      if (errResponse == exhaustedError) {
        apiKey = apiKey2;
      }
      print('omo $errResponse');
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ArticleResponse.withError(error.toString());
    }
  }

  Future<ArticleResponse> getTopNgHeadlines() async {
    var params = {"apiKey": apiKey, "country": "ng"};
    try {
      Response response =
          await _dio.get(getTopHeadlinesUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      errResponse = error.response.data["code"].toString();
      if (errResponse == exhaustedError) {
        apiKey = apiKey2;
      }
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ArticleResponse.withError(error);
    }
  }

  Future<ArticleResponse> getHotSarsNews() async {
    var params = {"apiKey": apiKey, "q": "breaking", "sortBy": "popularity"};
    try {
      Response response =
          await _dio.get(everythingUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      errResponse = error.response.data["code"].toString();
      if (errResponse == exhaustedError) {
        apiKey = apiKey2;
      }
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ArticleResponse.withError(error.toString());
    }
  }

  Future<ArticleResponse> getHotWizkidNews() async {
    var params = {"apiKey": apiKey, "q": "wizkid", "sortBy": "popularity"};
    try {
      Response response =
          await _dio.get(everythingUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      errResponse = error.response.data["code"].toString();
      if (errResponse == exhaustedError) {
        apiKey = apiKey2;
      }
      print("Exception occurred: $error stacktrace: $stacktrace");
      return ArticleResponse.withError(error.toString());
    }
  }
}
