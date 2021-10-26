import 'package:base_flutter_project/model/git_response.dart';
import 'package:base_flutter_project/ui/base/base_bloc.dart';

abstract class ApiManager implements Disposable {
  void setToken(String token);

  Future<GitResponse> getGitResponse();
}
