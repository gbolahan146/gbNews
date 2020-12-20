import 'package:justnews/model/article_response.dart';
import 'package:justnews/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class GetTopNgHeadlinesBloc {
  final NewsRepository _repository = NewsRepository();
  final BehaviorSubject<ArticleResponse> _subject =
      BehaviorSubject<ArticleResponse>();

  getNgHeadlines() async {
    ArticleResponse response = await _repository.getTopNgHeadlines();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ArticleResponse> get subject => _subject;
}

final getTopNgHeadlinesBloc = GetTopNgHeadlinesBloc();
