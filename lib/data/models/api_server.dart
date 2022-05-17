import 'dart:io';

class KServer {
  final InternetAddress address;
  final int port;
  final String name;
  final bool public;

  KServer({
    required this.name,
    required this.public,
  })  : address = InternetAddress.loopbackIPv4,
        port = 4040;
}
