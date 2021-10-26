import 'dart:ui';

import 'package:base_flutter_project/utils/string_extenstion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../application.dart';
import 'base_bloc.dart';

abstract class BaseState<W extends StatefulWidget, B extends BaseBloc>
    extends State<W> {
  String titleScreen();

  Widget? createBodyWidget();

  void onListenerStream();

  late B bloc;
  late BuildContext mContext;
  var blocFactory = Application.instance.blocFactory;

  void initData() {}

  @override
  void initState() {
    super.initState();
    bloc = blocFactory.createModelClass(B);
    onListenerStream();
    initData();
    bloc.progressBar.listen((isLoading) async {
      printLog("${isLoading ? 'ShowLoading' : 'HideLoading'}");
      if (isLoading) {
        showLoading();
      } else {
        Navigator.pop(mContext);
      }
    });
    bloc.trackingError.listen((errorModel) {
      var messageError = errorModel.message;
      if (messageError.isEmpty) return;
      showMyDialog(messageError);
    });
  }

  @override
  Widget build(BuildContext context) {
    printLog('build');
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(titleScreen()),
        centerTitle: true,
      ),
      body: BlocProvider(
        child: createBodyWidget()!,
        bloc: bloc,
      ),
    );
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
    print('dispose');
  }

  void showLoading() async {
    await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          mContext = context;
          return Center(
            child: CircularProgressIndicator(),
          );
        });
  }

  void pushScreen(Widget widget, {rootNavigator: false}) async {
    await Navigator.of(context, rootNavigator: rootNavigator)
        .push(MaterialPageRoute(builder: (con) => widget));

    onResume();
  }

  void popScreen() {
    Navigator.pop(context);
  }

  Future<void> showMyDialog(String message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Thông báo',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void onResume() {}
}
