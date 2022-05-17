import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../src/classes/client.dart';

part 'authenticator_state.dart';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

String generateKey(int length, Random _rnd) =>
    String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

class AuthenticatorCubit extends Cubit<AuthenticatorState> {
  final String? publicKey;

  AuthenticatorCubit(bool isPublic)
      : publicKey = isPublic ? randomKey : null,
        super(AuthenticatorState.init());

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

  void removeClient(String token) => emit(state.withoutClient(token));
}
