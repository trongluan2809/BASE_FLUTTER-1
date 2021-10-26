import 'package:base_flutter_project/utils/app_color.dart';
import 'package:flutter/material.dart';

import 'tab_category/tab_category.dart';
import 'tab_home/tab_home.dart';
import 'tab_info/tab_info.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final _tabNavigator = GlobalKey<TabNavigatorState>();
  final _tab1 = GlobalKey<NavigatorState>();
  final _tab2 = GlobalKey<NavigatorState>();
  final _tab3 = GlobalKey<NavigatorState>();

  var _tabSelectedIndex = 0;
  var _tabPopStack = false;

  void _setIndex(index) {
    setState(() {
      _tabPopStack = _tabSelectedIndex == index; // double click pop to root
      _tabSelectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  void _checkPermission() async {
    // var status = await Permission.location.request();
    // if (status.isGranted) {
    // } else {
    //   //TODO open permission
    // }
    // await Permission.camera.request();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !(await _tabNavigator.currentState?.maybePop())!,
      child: Scaffold(
        body: TabNavigator(
          key: _tabNavigator,
          tabs: <TabItem>[
            TabItem(_tab1, TabHomeScreen()),
            TabItem(_tab2, TabCategoryScreen()),
            TabItem(_tab3, TabInfoScreen()),
          ],
          selectedIndex: _tabSelectedIndex,
          popStack: _tabPopStack,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _tabSelectedIndex,
          selectedItemColor: AppColor.primaryColor,
          onTap: _setIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.audiotrack),
              label: 'Audio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.ondemand_video),
              label: 'Video',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz),
              backgroundColor: AppColor.primaryColor,
              label: 'More',
            ),
          ],
        ),
      ),
    );
  }
}

class TabItem {
  final GlobalKey<NavigatorState> key;
  final Widget tab;

  const TabItem(this.key, this.tab);
}

class TabNavigator extends StatefulWidget {
  final List<TabItem> tabs;
  final int selectedIndex;
  final bool popStack;

  TabNavigator({
    required Key key,
    required this.tabs,
    required this.selectedIndex,
    this.popStack = false,
  }) : super(key: key);

  @override
  TabNavigatorState createState() => TabNavigatorState();
}

class TabNavigatorState extends State<TabNavigator> {
  ///
  /// Try to pop widget, return true if popped
  ///
  Future<bool> maybePop() {
    return widget.tabs[widget.selectedIndex].key.currentState!.maybePop();
  }

  _popStackIfRequired(BuildContext context) async {
    if (widget.popStack) {
      widget.tabs[widget.selectedIndex].key.currentState!
          .popUntil((route) => route.isFirst);
    }
  }

  @override
  Widget build(BuildContext context) {
    print('selectedIndex=${widget.selectedIndex}, popStack=${widget.popStack}');
    _popStackIfRequired(context);

    return Stack(
      children: List.generate(widget.tabs.length, _buildTab),
    );
  }

  Widget _buildTab(int index) {
    return Offstage(
      offstage: widget.selectedIndex != index,
      child: Opacity(
        opacity: widget.selectedIndex == index ? 1.0 : 0.0,
        child: Navigator(
          key: widget.tabs[index].key,
          onGenerateRoute: (settings) => MaterialPageRoute(
            settings: settings,
            builder: (_) => widget.tabs[index].tab,
          ),
        ),
      ),
    );
  }
}
