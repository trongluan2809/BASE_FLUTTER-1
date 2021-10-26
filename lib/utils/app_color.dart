import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'string_extenstion.dart';

class AppColor {
  static final Color backgroundColor = Color(0xFF059546);
  static final Color primaryColor = Color(0xFF059546);
  static final Color white = Colors.white;
  static final Color grey = Colors.grey;
  static final Color blue = Colors.blueAccent;

  static Color convert(String color) {
    try {
      color = color.replaceAll("#", "");
      if (color.length == 6) {
        return Color(int.parse("0xFF" + color));
      } else if (color.length == 8) {
        return Color(int.parse("0x" + color));
      }
    } catch (ex) {
      printLog('color convert exception: $ex');
    }
    return primaryColor;
  }

  static var rnd = math.Random();

  static List<Color> randomColor({int numberColor = 1}) {
    return List.generate(numberColor, (index) => Color(rnd.nextInt(0xffffffff)))
        .toList();
  }
}
