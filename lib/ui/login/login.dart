import 'dart:ui';

import 'package:base_flutter_project/ui/base/base_bloc.dart';
import 'package:base_flutter_project/ui/base/base_state.dart';
import 'package:base_flutter_project/ui/dashboard/dashboard.dart';
import 'package:base_flutter_project/utils/app_color.dart';
import 'package:base_flutter_project/utils/string_extenstion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'login_bloc.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends BaseState<LoginScreen, LoginBloc> {
  final Color backgroundColor = AppColor.primaryColor;
  final Color primaryColor = AppColor.primaryColor;

  late FocusNode userNameFocus, passwordFocus;

  final _userNameController = TextEditingController(text: 'Miichisoft');
  final _passwordController = TextEditingController(text: 'Miichisoft');
  bool _passwordVisible = false;
  bool _isEnableButtonLogin = true;

  //Variable for TextFiled
  Color colorEnable = Colors.white;
  Color colorDisable = Colors.black38;
  double fontSize = 18.0;

  @override
  String titleScreen() => "";

  @override
  Widget? createBodyWidget() => null;

  @override
  void initData() {
    _passwordVisible = true;
    userNameFocus = FocusNode();
    passwordFocus = FocusNode();

    userNameFocus.addListener(() {
      setState(() {
        //reload data
      });
    });
    passwordFocus.addListener(() {
      setState(() {
        //reload data
      });
    });
  }

  @override
  void onListenerStream() {
    bloc.validSubject.listen((event) {
      showMyDialog(event);
    });
    bloc.resultLogin.listen((event) {
      Navigator.push(
          context, MaterialPageRoute(builder: (con) => DashboardScreen()));
    });
    _checkEnableButtonLogin();
    _userNameController.addListener(_checkEnableButtonLogin);
    _passwordController.addListener(_checkEnableButtonLogin);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          colorFilter: ColorFilter.linearToSrgbGamma(),
          image: AssetImage("images/ic_test.jpg"),
        ),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: BlocProvider(
              child: Center(
                child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Flexible(
                          child: Container(),
                          flex: 1,
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 20),
                              child: Text(
                                'Miichisoft',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32,
                                    color: primaryColor),
                              ),
                            ),
                            _createTFUserName(),
                            _createTFPassword(),
                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: _createButtonLogin(),
                            ),
                          ],
                        ),
                        Flexible(
                          child: Container(),
                          flex: 1,
                        ),
                      ],
                    )),
              ),
              bloc: bloc,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
  }

  _checkEnableButtonLogin() {
    String userName = _userNameController.text;
    String password = _passwordController.text;
    _isEnableButtonLogin = userName.isNotEmpty && password.isNotEmpty;
    setState(() {
      //render ui
    });
  }

  double _strokeValue(bool enable) {
    return enable ? 2 : 1.0;
  }

  TextField _createTFUserName() {
    String text = _userNameController.text;
    bool isEnable = (userNameFocus.hasFocus || text.isNotEmpty);
    Color userNameColor = isEnable ? colorEnable : colorDisable;
    double userNameStroke = _strokeValue(isEnable);
    return TextField(
      style: TextStyle(color: colorEnable, fontSize: fontSize),
      focusNode: userNameFocus,
      controller: _userNameController,
      autofocus: false,
      decoration: new InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: userNameColor, width: userNameStroke),
        ),
        labelStyle: TextStyle(color: userNameColor),
        focusedBorder: new OutlineInputBorder(
            borderSide:
                new BorderSide(color: userNameColor, width: userNameStroke)),
        border: new OutlineInputBorder(
            borderSide:
                new BorderSide(color: userNameColor, width: userNameStroke)),
        //show error
        labelText: 'Tài khoản',
        helperText: '',
        prefixIcon: Icon(
          Icons.person,
          color: userNameColor,
        ),
      ),
    );
  }

  TextField _createTFPassword() {
    String text = _passwordController.text;
    bool isEnable = (passwordFocus.hasFocus || text.isNotEmpty);
    Color passwordColor = isEnable ? colorEnable : colorDisable;
    double passwordStroke = _strokeValue(isEnable);
    return TextField(
      style: TextStyle(color: colorEnable, fontSize: fontSize),
      focusNode: passwordFocus,
      controller: _passwordController,
      obscureText: _passwordVisible,
      autofocus: false,
      decoration: new InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: passwordColor, width: passwordStroke),
        ),
        labelStyle: TextStyle(color: passwordColor),
        focusedBorder: new OutlineInputBorder(
            borderSide:
                new BorderSide(color: passwordColor, width: passwordStroke)),
        border: new OutlineInputBorder(
            borderSide:
                new BorderSide(color: passwordColor, width: passwordStroke)),
        //show error
        labelText: 'Mật khẩu',
        prefixIcon: Icon(
          Icons.lock,
          color: passwordColor,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: passwordColor,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
        helperText: '',
      ),
    );
  }

  ElevatedButton _createButtonLogin() {
    var onPressed = _isEnableButtonLogin
        ? () {
            String userName = _userNameController.text;
            String password = _passwordController.text;
            bloc.onLogin(userName, password);
          }
        : null;
    return ElevatedButton(child: Text('Đăng nhập'), onPressed: onPressed);
  }
}
