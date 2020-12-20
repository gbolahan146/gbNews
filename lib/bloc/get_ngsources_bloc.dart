import 'package:justnews/model/source_response.dart';
import 'package:justnews/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class GetNgSourcesBloc {
  final NewsRepository _repository = NewsRepository();
  final BehaviorSubject<SourceResponse> _subject =
      BehaviorSubject<SourceResponse>();

  getNgSources() async {
    SourceResponse response = await _repository.getNgSources();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<SourceResponse> get subject => _subject;
}

final getNgSourcesBloc = GetNgSourcesBloc();
