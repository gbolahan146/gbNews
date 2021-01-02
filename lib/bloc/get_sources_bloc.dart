import 'package:justnews/model/source_response.dart';
import 'package:justnews/repository/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetSourcesBloc {
  final NewsRepository _repository = NewsRepository();
  final BehaviorSubject<SourceResponse> _subject =
      BehaviorSubject<SourceResponse>();

  getSources() async {
    int index = await  getValidApiKey();
    //If value is null pass 0.
    SourceResponse response = await _repository.getSources(index ?? 0,0);
    _subject.sink.add(response);
  }

  Future<int> getValidApiKey() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getInt('ValidApiKey');
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<SourceResponse> get subject => _subject;
}

final getSourcesBloc = GetSourcesBloc();
