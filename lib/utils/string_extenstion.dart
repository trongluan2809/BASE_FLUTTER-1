import 'dart:isolate';

import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

final DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
final Logger logger = Logger(
  printer: PrettyPrinter(
      methodCount: 2,
      // number of method calls to be displayed
      errorMethodCount: 8,
      // number of method calls if stacktrace is provided
      lineLength: 120,
      // width of the output
      colors: true,
      // Colorful log messages
      printEmojis: true,
      // Print an emoji for each log message
      printTime: false // Should each log print contain a timestamp
      ),
);

void printLog(Object message) {
  final DateTime now = DateTime.now();
  String formatted = formatter.format(now);
  logger.d('[$formatted] [${Isolate.current.debugName}] => $message');
}

// String formatStackTrace() {
//   StackTrace stackTrace = StackTrace.current;
//   var lines = stackTrace.toString().split('\n');
//   print('$lines');
//   if (lines.length == 0) {
//     return null;
//   }
//   return '${lines[1]}';
// }
