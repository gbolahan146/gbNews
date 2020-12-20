import 'package:justnews/model/article_response.dart';
import 'package:justnews/repository/repository.dart';
import 'package:rxdart/subjects.dart';

class GetHotNewsBloc {
  final NewsRepository _repository = NewsRepository();
  final BehaviorSubject<ArticleResponse> _subject =
      BehaviorSubject<ArticleResponse>();

  getHotNews() async {
    ArticleResponse response = await _repository.getHotNews();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ArticleResponse> get subject => _subject;
}


class GetHotBtcNewsBloc {
  final NewsRepository _repository = NewsRepository();
  final BehaviorSubject<ArticleResponse> _subject =
      BehaviorSubject<ArticleResponse>();

  getBtcHotNews() async {
    ArticleResponse response = await _repository.getBtcHotNews();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ArticleResponse> get subject => _subject;
}

final getHotNewsBloc = GetHotNewsBloc();
final getBtcHotNewsBloc = GetHotBtcNewsBloc();
