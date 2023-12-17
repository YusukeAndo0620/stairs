import 'package:logger/logger.dart';
import 'package:intl/intl.dart';

Logger stairsLogger({required String name}) {
  return Logger(
      printer: _StairsLogPrinter(name: name), output: _StairsLogOutput());
}

class _StairsLogPrinter extends LogPrinter {
  _StairsLogPrinter({required this.name});
  final String name;

  @override
  List<String> log(LogEvent event) {
    final message = event.message;

    String msg;
    if (message is Function()) {
      msg = message().toString();
    } else if (message is String) {
      msg = message;
    } else {
      msg = message.toString();
    }
    return [
      '$name: [${event.level.name.toUpperCase()}] '
          '${DateFormat('HH:mm:ss.SSS').format(DateTime.now())}: '
          '$msg'
    ];
  }
}

class _StairsLogOutput extends ConsoleOutput {
  @override
  void output(OutputEvent event) {
    super.output(event);
    if (event.level.index >= Level.error.index) {
      throw AssertionError('View stack trace by logger');
    }
  }
}
