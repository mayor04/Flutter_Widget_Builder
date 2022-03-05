import 'dart:developer';

class AppLog {
  final String className;
  AppLog(this.className);

  final String _errorAnsi = '\u001b[31m';
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

  void debug(String method, var objects) {
    log('$_whiteAnsi${_getLine(170)}');
    log('$_debugAnsi$objects', name: '$_debugAnsi$className > $method');
  }

  void error(String method, String error) {
    log('$_errorAnsi$error', name: '$_errorAnsi$className > $method');
  }

  void info(String method, var info) {
    log('$info', name: '$className > $method');
  }
}
