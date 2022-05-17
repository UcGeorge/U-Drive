import 'dart:math';

import 'client.dart';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

String generateKey(int length, Random _rnd) =>
    String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

class Authenticator {
  final bool isPublic;
  final String? publicKey;
  Map<String, Client> _authorizedClients = {};

  Authenticator(this.isPublic) : publicKey = isPublic ? randomKey : null;

  static String get randomKey =>
      generateKey(64, Random(DateTime.now().millisecond));

  bool isAuthenticated(String token) => _authorizedClients.containsKey(token);

  Client addClient(String name) {
    var client = Client(
      token: isPublic ? publicKey! : randomKey,
      name: name,
    );
    _authorizedClients[client.token] = client;
    return client;
  }

  void removeClient(String token) => _authorizedClients.remove(token);
}
