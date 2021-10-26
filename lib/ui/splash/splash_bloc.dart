import 'package:base_flutter_project/ui/base/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SplashBloc extends BaseBloc {
  final _isLogin = PublishSubject<bool>();

  Stream<bool> get isLogin => _isLogin.stream;

  SplashBloc() {
    _checkLogin();
  }

  void _checkLogin() async {
    await Future.delayed(Duration(seconds: 2));
    var isLogin = await dataManager.isLogin();
    _isLogin.add(isLogin);
  }

  @override
  void dispose() {
    super.dispose();
    _isLogin.close();
  }
}
