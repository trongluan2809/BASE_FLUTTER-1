import 'package:base_flutter_project/ui/base/base_bloc.dart';
import 'package:base_flutter_project/ui/base/base_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'tab_category_bloc.dart';

class TabCategoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TabCategoryState();
  }
}

class _TabCategoryState extends BaseState<TabCategoryScreen, TabCategoryBloc> {
  @override
  void onListenerStream() {}

  @override
  Widget? createBodyWidget() => null;

  @override
  String titleScreen() => "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
      ),
      body: BlocProvider(
          bloc: bloc,
          child: Row(
            children: [
              Expanded(
                flex: 30,
                child: Text('Category'),
              ),
              Expanded(
                flex: 70,
                child: Container(
                  child: RaisedButton(
                    child: Text('Click'),
                    onPressed: () {
                      // Navigator.push(context,
                      //     MaterialPageRoute(builder: (con) => TabInfoScreen()));
                    },
                  ),
                ),
              )
            ],
          )),
    );
  }
}
