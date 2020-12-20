import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:justnews/model/article_response.dart';
import 'package:justnews/model/source_response.dart';

class NewsRepository {
  static String mainUrl = "https://newsapi.org/v2/";
  String apiKey = DotEnv().env['apiKey'];
  final String apiKey2 = DotEnv().env['apiKey2'];
  String errResponse;
  String exhaustedError = 'apiKeyExhausted';

  final Dio _dio = Dio();

  var getSourcesUrl = "$mainUrl/sources";
  var getTopHeadlinesUrl = "$mainUrl/top-headlines";
  var everythingUrl = "$mainUrl/everything";

  Future<SourceResponse> getSources() async {
    var params = {
      "apiKey": apiKey,
      "language": "en",
    };
    try {
      Response response =
          await _dio.get(getSourcesUrl, queryParameters: params);
      return SourceResponse.fromJson(response.data);
    } catch (error) {
      errResponse = error.response.data["code"].toString();
      if (errResponse == exhaustedError) {
        apiKey = apiKey2;
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
