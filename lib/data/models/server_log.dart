abstract class ServerLog {
  LogType get type;
  String get message;
  String? get body;
  DateTime get timeStamp;
}

enum LogType {
  probe,
  serverMessage,
  networkRequest,
  warning,
}

class ServerMessageLog implements ServerLog {
  final String _message;
  final String? _body;

  ServerMessageLog(this._message, [this._body]);

  @override
  String? get body => _body;

  @override
  String get message => _message;

  @override
  DateTime get timeStamp => DateTime.now();

  @override
  LogType get type => LogType.serverMessage;
}

class NetworkRequestLog implements ServerLog {
  final String _message;
  final String? _body;

  NetworkRequestLog(this._message, [this._body]);

  @override
  String? get body => _body;

  @override
  String get message => _message;

  @override
  DateTime get timeStamp => DateTime.now();

  @override
  LogType get type => LogType.networkRequest;
}

class CloseServerLog implements ServerLog {
  @override
  String? get body => null;

  @override
  String get message => 'Server is closing';

  @override
  DateTime get timeStamp => DateTime.now();

  @override
  LogType get type => LogType.warning;
}
