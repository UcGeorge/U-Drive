import 'dart:async';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:u_drive/data/models/server_log.dart';
import 'package:u_drive/logic/cubit/server_cubit.dart';

import '../classes/client.dart';
import 'request_access_cubit.dart';

part 'authenticator_state.dart';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

String generateKey(int length, Random _rnd) =>
    String.fromCharCodes(Iterable.generate(
      length,
      (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)),
    ));

typedef ClientCallback = void Function(Client? client);

class AuthenticatorCubit extends Cubit<AuthenticatorState> {
  final String? publicKey;
  final RequestAccessCubit requestAccessCubit;
  late ServerCubit _serverCubit;

  AuthenticatorCubit(bool isPublic, this.requestAccessCubit)
      : publicKey = isPublic ? randomKey : null,
        super(AuthenticatorState.init(isPublic)) {
    requestAccessCubit.stream.listen((event) => print(event));
  }

  set serverCubit(ServerCubit serverCubit) {
    _serverCubit = serverCubit;
  }

  static String get randomKey =>
      generateKey(64, Random(DateTime.now().millisecond));

  bool isAuthenticated(String token) => state.isAuthenticated(token);

  Client addClient(String name) {
    var client = Client(
      token: state.isPublic ? publicKey! : randomKey,
      name: name,
    );
    emit(state.withNewClient(client));
    return client;
  }

  void clear() => emit(AuthenticatorState.init(state.isPublic));

  void removeClient(String token) {
    _serverCubit.log(WarningServerLog(
        'Revoked access for ${state._authorizedClients[token]!.name}'));
    emit(state.withoutClient(token));
  }

  void clearRequests() => emit(state.copyWith(accessRequested: false));

  Future<void> requestAccess(
    String clientName,
    ClientCallback onComplete,
  ) async {
    if (!state.accessRequested) {
      emit(state.copyWith(accessRequested: true));
    }

    Future.delayed(
      const Duration(seconds: 1),
      () => requestAccessCubit.requestAccess(clientName),
    );

    var requestCubitStream = requestAccessCubit.stream;

    late StreamSubscription<RequestAccessState> subscription;
    subscription = requestCubitStream.listen(
      (requestState) {
        try {
          bool? hasAccess = requestState.requests[clientName];
          if (hasAccess == null) {
          } else if (hasAccess) {
            Client requestClient = Client(
              token: randomKey,
              name: clientName,
            );
            emit(state.withNewClient(requestClient));
            onComplete(requestClient);
            subscription.cancel();
          } else {
            onComplete(null);
            subscription.cancel();
          }
        } on Exception catch (_) {}
      },
      onError: (o) {},
      cancelOnError: true,
    );
  }
}
