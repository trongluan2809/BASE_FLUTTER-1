import 'package:base_flutter_project/model/git_response.dart';
import 'package:base_flutter_project/ui/base/base_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'tab_home_bloc.dart';

class TabHomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TabHomeState();
  }
}

class _TabHomeState extends BaseState<TabHomeScreen, TabHomeBloc> {
  _TabHomeState();

  @override
  String titleScreen() => "Trang chủ";

  @override
  void onListenerStream() {}

  @override
  Widget createBodyWidget() {
    return Container(
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.0)),
      child: StreamBuilder(
        initialData: null,
        stream: bloc.listGithub,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<RepoModel> listRepo = snapshot.data as List<RepoModel>;
            return ListView.separated(
                itemBuilder: (context, index) {
                  var repoModel = listRepo[index];
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.grey,
                          backgroundImage:
                              NetworkImage(repoModel.owner.avatarUrl),
                        ),
                        title: Text(repoModel.fullName),
                        onTap: () {},
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(height: 10);
                },
                itemCount: listRepo.length);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  final String text = "Hello";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      child: Text(text),
      color: Colors.green,
    );
  }
}
