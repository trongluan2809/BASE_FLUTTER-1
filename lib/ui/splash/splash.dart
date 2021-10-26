import 'package:base_flutter_project/ui/login/login.dart';
import 'package:base_flutter_project/utils/app_color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../base/base_state.dart';
import '../dashboard/dashboard.dart';
import 'splash_bloc.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashState();
  }
}

class _SplashState extends BaseState<SplashScreen, SplashBloc> {
  @override
  void onListenerStream() {
    bloc.isLogin.listen((isLogin) {
      if (!isLogin) {
        pushScreen(LoginScreen());
      } else {
        pushScreen(DashboardScreen());
      }
    });
  }

  @override
  void initData() {}

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.9],
            colors: [
              AppColor.primaryColor,
              AppColor.primaryColor,
            ],
          ),
        ),
        child: Text(
          'Miichisoft',
          style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              decoration: TextDecoration.none),
        ));
  }

  @override
  Widget? createBodyWidget() => null;

  @override
  String titleScreen() => "";
}
