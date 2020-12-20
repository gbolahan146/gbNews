import 'package:justnews/model/article_response.dart';
import 'package:justnews/repository/repository.dart';
import 'package:rxdart/subjects.dart';

class GetHotWizkidNewsBloc {
  final NewsRepository _repository = NewsRepository();
  final BehaviorSubject<ArticleResponse> _subject =
      BehaviorSubject<ArticleResponse>();

  getHotWizkidNews() async {
    ArticleResponse response = await _repository.getHotWizkidNews();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ArticleResponse> get subject => _subject;
}

final getHotWizkidNewsBloc = GetHotWizkidNewsBloc();
