import 'package:base_flutter_project/ui/base/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BaseBloc {
  PublishSubject<String> _validSubject = PublishSubject();

  Stream<String> get validSubject => _validSubject.stream;

  PublishSubject<bool> _resultLogin = PublishSubject();

  Stream<bool> get resultLogin => _resultLogin.stream;

  void onLogin(String userName, String password) async {
    progressBar.add(true);
    await Future.delayed(Duration(seconds: 1));
    var success = await dataManager.saveAccount(userName, password);
    progressBar.add(false);
    _resultLogin.add(success);
  }

  @override
  void dispose() {
    super.dispose();
    _validSubject.close();
    _resultLogin.close();
  }
}
