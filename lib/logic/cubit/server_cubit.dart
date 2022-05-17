import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/api_server.dart';
import '../../data/models/server_log.dart';
import '../src/classes/api_response.dart';
import '../src/handlers/get.dart';
import '../src/handlers/post.dart';
import 'authenticator_cubit.dart';

part 'server_state.dart';

class ServerCubit extends Cubit<ServerState> {
  final AuthenticatorCubit _authenticator;
  final KServer _server;
  final ScrollController logsScrollController;
  late HttpServer _httpServer;

  ServerCubit(this._server)
      : _authenticator = AuthenticatorCubit(_server.public),
        logsScrollController = ScrollController(),
        super(ServerState.init());

  void log(ServerLog log) {
    emit(state.log(log));
    if (logsScrollController.hasClients) {
      logsScrollController.animateTo(
        (state.logs.length * 48),
        curve: Curves.linear,
        duration: const Duration(milliseconds: 500),
      );
    }
  }

  void start() async {
    // print(
    //     '${_server.public ? 'Public' : 'Private'} HTTP Server started: $_server.address port $_server.port');
    await _createServer();
    log(ServerMessageLog('Started Server'));
    log(ServerMessageLog('Created requests handler'));
    await _handleRequests();
    // emit(state.log(CloseServerLog()));
    print('${_server.public ? 'Public' : 'Private'} HTTP Server stopped');
  }

  void end() {
    _httpServer.close();
    log(CloseServerLog());
    emit(state.copyWith(running: false, logs: List.empty(growable: true)));
  }

  Future<void> _createServer() async {
    _httpServer = await HttpServer.bind(_server.address, _server.port);
  }

  Future<void> _handleRequests() async {
    await for (HttpRequest request in _httpServer) {
      log(NetworkRequestLog("${request.method}: ${request.uri.path}"));
      print(
          "${request.method}: ${request.uri.path} ${request.uri.hasQuery ? request.uri.queryParameters : ""}");
      switch (request.method) {
        case 'GET':
          GetHandler(request, _authenticator, this);
          break;
        case 'POST':
          PostHandler(request, _authenticator, this);
          break;
        default:
          _handleDefault(request);
      }
    }
  }

  void _handleDefault(HttpRequest request) {
    request.response
      ..statusCode = HttpStatus.methodNotAllowed
      ..write(ApiResponse.bad('Unsupported method: ${request.method}'))
      ..close();
  }

  @override
  Future<void> close() {
    // print('Server is closing');
    log(CloseServerLog());
    end();
    return super.close();
  }
}
