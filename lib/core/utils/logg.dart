import 'dart:developer';

class AppLog {
  final String className;
  AppLog(this.className);

  final String _errorAnsi = '\u001b[31m';
  final String _errorbgAnsi = '\u001b[41m';
  final String _debugAnsi = '\u001b[32m';
  final String _whiteAnsi = '\u001b[37m';

//Draws line to create a demarkation for the logs
  String _getLine(int count) {
    String equal = '-';

    for (int i = 0; i < count; i++) {
      equal += '-';
    }

    return equal;
  }

  void out(String method, var objects) {
    log('$_whiteAnsi$objects', name: '$_whiteAnsi$className > $method');
  }

  void debug(String method, var objects) {
    log('$_whiteAnsi${_getLine(170)}');
    log('$_debugAnsi$objects', name: '$_debugAnsi$className > $method');
  }

  void error(String method, String error) {
    log('$_whiteAnsi$_errorbgAnsi$error  ',
        name: '$_whiteAnsi$className > $method');
  }

  static void warn(String method, String warn) {
    log('\u001b[33;1m$warn', name: '\u001b[33;1m$method');
  }

  static void info(String method, var info) {
    log('\u001b[37m$info', name: '\u001b[37m$method');
  }
}
