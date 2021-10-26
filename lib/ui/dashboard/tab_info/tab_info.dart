import 'package:base_flutter_project/ui/base/base_bloc.dart';
import 'package:base_flutter_project/ui/base/base_state.dart';
import 'package:flutter/material.dart';

import 'tab_info_bloc.dart';

class TabInfoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TabInfoState();
  }
}

class _TabInfoState extends BaseState<TabInfoScreen, TabInfoBloc> {
  @override
  void initData() {}

  @override
  void onListenerStream() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Info'),
      ),
      body: BlocProvider(
        bloc: bloc,
        child: Builder(
          builder: (mContext) {
            return Center(
              child: RaisedButton(child: Text("Click"), onPressed: () {}),
            );
          },
        ),
      ),
    );
  }

  @override
  Widget? createBodyWidget() => null;

  @override
  String titleScreen() => "";
}
