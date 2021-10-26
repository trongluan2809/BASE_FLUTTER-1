import 'package:base_flutter_project/ui/login/login.dart';
import 'package:flutter/material.dart';

import 'ui/splash/splash.dart';
import 'utils/app_color.dart';

// SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle
// (
// statusBarColor: Colors.transparent,statusBarBrightness: Brightness
//     .dark,statusBarIconBrightness: Brightness
//     .dark,systemNavigationBarColor: Colors
//     .transparent,systemNavigationBarIconBrightness: Brightness.dark,)
// );

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'OpenYourEyes',
      theme: ThemeData(
        // Define the default brightness and colors.
        primaryColor: AppColor.primaryColor,
        accentColor: AppColor.primaryColor,
        cursorColor: AppColor.primaryColor,

        // Define the default font family.

        fontFamily: 'Roboto',

        // Define the default TextTheme. Use this to specify the default
        // text styling for headlines, titles, bodies of text, and more.
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(
            fontSize: 14.0,
            fontFamily: 'Roboto',
          ),
        ),
      ),
      home: SplashScreen(),
    );
  }
}
