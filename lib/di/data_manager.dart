import 'package:base_flutter_project/ui/base/base_bloc.dart';

abstract class DataManager implements Disposable {
  Future<bool> saveAccount(String userName, String password);

  Future<bool> isLogin();
}
