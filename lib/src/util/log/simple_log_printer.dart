import 'package:intl/intl.dart';
import 'package:logger/logger.dart';

class SimpleLogPrinter extends LogPrinter {

  final String className;

  SimpleLogPrinter(this.className);

  @override
  List<String> log(LogEvent event) {
    var color = PrettyPrinter.levelColors[event.level];
    var emoji = PrettyPrinter.levelEmojis[event.level];
    final now= DateTime.now();
    String formatted= DateFormat('y-MMMM-d H:m:s').format(now);
    return [color('$formatted $emoji $className - ${event.message}')];
  }
}

Logger getLogger(String className) => Logger(printer: SimpleLogPrinter(className));