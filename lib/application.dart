import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'di/api_manger.dart';
import 'di/app_api_manager.dart';
import 'di/app_data_manager.dart';
import 'di/data_manager.dart';
import 'ui/base/base_bloc.dart';
import 'ui/block_factory.dart';

class Application implements Disposable {
  static final Application _singleton = Application._internal();

  static Application get instance => _singleton;

  late DataManager dataManger;
  late ApiManager apiManager;
  late BlocFactory blocFactory;

  Application._internal() {
    dataManger = AppDataManager.instance;
    apiManager = AppApiManager.instance;
    blocFactory = BlocFactory();
  }

  @override
  void dispose() {
    dataManger.dispose();
    apiManager.dispose();
  }
}
