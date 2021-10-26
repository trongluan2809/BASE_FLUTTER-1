import 'package:base_flutter_project/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data_manager.dart';

class AppDataManager extends DataManager {
  static final AppDataManager _singleton = AppDataManager._internal();

  AppDataManager._internal();

  static AppDataManager get instance => _singleton;

  Future<SharedPreferences> get _sharePreference async {
    return await SharedPreferences.getInstance();
  }

  @override
  void dispose() {
    // apiManager.dispose();
  }

  /*===============> DbManager <===============*/

  /*===============> SharePrefManager <===============*/
  @override
  Future<bool> saveAccount(String userName, String password) async {
    var sharePreference = await _sharePreference;
    var one = sharePreference.setString(ShareConst.userName, userName);
    var second = sharePreference.setString(ShareConst.password, password);
    var result = await Future.wait([one, second]);
    var success = result.any((element) => element);
    return Future.value(success);
  }

  @override
  Future<bool> isLogin() async {
    var sharePreference = await _sharePreference;
    String userName = sharePreference.getString(ShareConst.userName) ?? "";
    String password = sharePreference.getString(ShareConst.password) ?? "";
    return Future.value(userName.isNotEmpty && password.isNotEmpty);
  }
}
