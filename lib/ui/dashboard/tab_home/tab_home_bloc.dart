import 'package:base_flutter_project/model/git_response.dart';
import 'package:base_flutter_project/ui/base/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class TabHomeBloc extends BaseBloc {
  var _listGithub = BehaviorSubject<List<RepoModel>>();

  Stream<List<RepoModel>> get listGithub => _listGithub.stream;

  TabHomeBloc() {
    getListRepo();
  }

  @override
  void dispose() {
    super.dispose();
    _listGithub.close();
  }

  void getListRepo() {
    coroutineScope<GitResponse>(apiManager.getGitResponse(), (response) async {
      _listGithub.add(response.items);
    }, isShowLoading: false);
  }
}
