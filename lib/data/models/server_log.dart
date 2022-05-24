abstract class ServerLog {
  final DateTime _timeStamp;

  ServerLog() : _timeStamp = DateTime.now();

  LogType get type;
  String get message;
  String? get body;
  DateTime get timeStamp => _timeStamp;
}

enum LogType {
  probe,
  serverMessage,
  networkRequest,
  warning,
}

class ServerMessageLog extends ServerLog {
  final String _message;
  final String? _body;

  ServerMessageLog(this._message, [this._body]);

  @override
  String? get body => _body;

  @override
  String get message => _message;

  @override
  LogType get type => LogType.serverMessage;
}

class NetworkRequestLog extends ServerLog {
  final String _message;
  final String? _body;

  NetworkRequestLog(this._message, [this._body]);

  @override
  String? get body => _body;

  @override
  String get message => _message;

  @override
  LogType get type => LogType.networkRequest;
}

class CloseServerLog extends ServerLog {
  @override
  String? get body => null;

  @override
  String get message => 'Server is closing';

  @override
  LogType get type => LogType.warning;
}

class WarningServerLog extends ServerLog {
  final String _message;
  WarningServerLog(this._message);
  @override
  String? get body => null;

  @override
  String get message => _message;

  @override
  LogType get type => LogType.warning;
}
