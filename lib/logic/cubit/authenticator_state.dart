part of 'authenticator_cubit.dart';

class AuthenticatorState {
  final bool isPublic;
  final bool accessRequested;
  final Map<String, Client> _authorizedClients;

  bool isAuthenticated(String token) => _authorizedClients.containsKey(token);

  Map<String, Client> get authorizedClients => _authorizedClients;

  AuthenticatorState({
    required this.isPublic,
    this.accessRequested = false,
    Map<String, Client>? authorizedClients,
  }) : _authorizedClients = authorizedClients ?? {};

  factory AuthenticatorState.init([bool? isPublic]) =>
      AuthenticatorState(isPublic: isPublic ?? true);

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
    bool? accessRequested,
    Map<String, Client>? authorizedClients,
  }) {
    return AuthenticatorState(
      isPublic: isPublic ?? this.isPublic,
      accessRequested: accessRequested ?? this.accessRequested,
      authorizedClients: authorizedClients ?? _authorizedClients,
    );
  }
}
