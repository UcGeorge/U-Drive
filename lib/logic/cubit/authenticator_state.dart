part of 'authenticator_cubit.dart';

class AuthenticatorState {
  final bool isPublic;
  final Map<String, Client> _authorizedClients;

  bool isAuthenticated(String token) => _authorizedClients.containsKey(token);

  AuthenticatorState(
      {this.isPublic = true, Map<String, Client>? authorizedClients})
      : _authorizedClients = authorizedClients ?? {};

  factory AuthenticatorState.init() => AuthenticatorState();

  AuthenticatorState withNewClient(Client client) {
    var al = _authorizedClients;
    al[client.token] = client;
    return copyWith(authorizedClients: al);
  }

  AuthenticatorState withoutClient(String token) {
    var al = _authorizedClients;
    al.remove(token);
    return copyWith(authorizedClients: al);
  }

  AuthenticatorState copyWith({
    bool? isPublic,
    Map<String, Client>? authorizedClients,
  }) {
    return AuthenticatorState(
      isPublic: isPublic ?? this.isPublic,
      authorizedClients: authorizedClients ?? _authorizedClients,
    );
  }
}
