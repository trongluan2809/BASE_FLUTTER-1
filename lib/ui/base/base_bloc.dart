import 'dart:async';

import 'package:base_flutter_project/di/api_manger.dart';
import 'package:base_flutter_project/model/error_model.dart';
import 'package:base_flutter_project/utils/string_extenstion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

import '../../application.dart';

typedef AsyncCallback<T> = Function(T);
typedef Future FunctionName(ApiManager apiManager);
typedef Test<T> = Function(Future<T> future);

abstract class BaseBloc implements Disposable {
  var progressBar = PublishSubject<bool>();
  var trackingError = PublishSubject<ErrorModel>();
  var dataManager = Application.instance.dataManger;
  var apiManager = Application.instance.apiManager;

  void coroutineScope<T>(Future<T> asyncCallback, AsyncCallback<T> response,
      {bool isShowLoading = true}) async {
    void showLoading({required bool isShow}) {
      if (!isShowLoading) return;
      progressBar.add(isShow);
    }

    showLoading(isShow: true);
    try {
      var result = await asyncCallback;
      showLoading(isShow: false);
      response(result);
    } catch (ex) {
      showLoading(isShow: false);
      printLog("error $ex");
      if (ex is ErrorModel) {
        trackingError.add(ex);
      }
    }
  }

  void coroutineScopeTest<T>(FunctionName(a)) async {}

  void parallelScope(List<Future> asyncCallback, AsyncCallback callback,
      {bool isShowLoading = true}) async {
    void showLoading({required bool isShow}) {
      if (!isShowLoading) return;
      progressBar.add(isShow);
    }

    showLoading(isShow: true);
    try {
      Future.wait(asyncCallback).then((value) {});
      var result = await asyncCallback;
      showLoading(isShow: false);
      callback(result);
    } catch (ex) {
      showLoading(isShow: false);
      printLog("error $ex");
      if (ex is ErrorModel) {
        trackingError.add(ex);
      }
    }
  }

  @override
  void dispose() {
    progressBar.close();
    trackingError.close();
  }
}

abstract class Disposable {
  void dispose();
}

class BlocProvider<T extends BaseBloc> extends StatefulWidget {
  BlocProvider({
    Key? key,
    required this.child,
    required this.bloc,
  }) : super(key: key);
  final Widget child;
  final T bloc;

  @override
  _BlocProviderState<T> createState() {
    return _BlocProviderState();
  }

  static T of<T extends BaseBloc>(BuildContext context) {
    final _BlocProviderInherited<T>? blocProvider = context
        .getElementForInheritedWidgetOfExactType<_BlocProviderInherited<T>>()
        ?.widget as _BlocProviderInherited<T>?;
    // var block = context.dependOnInheritedWidgetOfExactType<_BlocProviderInherited<T>>();
    return blocProvider!.bloc;
  }
}

class _BlocProviderState<T extends BaseBloc> extends State<BlocProvider<T>> {
  @override
  Widget build(BuildContext context) {
    return _BlocProviderInherited(child: widget.child, bloc: widget.bloc);
  }

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}

class _BlocProviderInherited<T extends BaseBloc> extends InheritedWidget {
  _BlocProviderInherited({
    Key? key,
    required Widget child,
    required this.bloc,
  }) : super(key: key, child: child);

  final T bloc;

  @override
  bool updateShouldNotify(_BlocProviderInherited oldWidget) {
    return false;
  }
}
