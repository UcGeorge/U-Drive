part of 'server_cubit.dart';

class ServerState {
  final bool running;
  final List<ServerLog> logs;

  ServerState({
    this.running = false,
    List<ServerLog>? logs,
  }) : logs = logs ?? [];

  factory ServerState.init() => ServerState();

  ServerState log(ServerLog log) {
    var newLogs = logs;
    newLogs.add(log);
    return ServerState(
      running: running,
      logs: newLogs,
    );
  }

  ServerState copyWith({
    bool? running,
    List<ServerLog>? logs,
  }) {
    return ServerState(
      running: running ?? this.running,
      logs: logs ?? this.logs,
    );
  }
}
