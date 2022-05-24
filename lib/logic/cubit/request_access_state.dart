part of 'request_access_cubit.dart';

class RequestAccessState extends Equatable {
  final Map<String, bool?> requests;
  final DateTime tStamp;

  RequestAccessState({Map<String, bool?>? requests})
      : requests = requests ?? {},
        tStamp = DateTime.now();
  factory RequestAccessState.init() => RequestAccessState();

  RequestAccessState withNewRequest(String clientName) {
    var al = requests;
    al[clientName] = null;
    return copyWith(requests: al);
  }

  RequestAccessState accept(String clientName) {
    print('Accepting $clientName');
    var al = requests;
    al[clientName] = true;
    return copyWith(requests: al);
  }

  RequestAccessState deny(String clientName) {
    print('Denying $clientName');
    var al = requests;
    al[clientName] = false;
    return copyWith(requests: al);
  }

  RequestAccessState acceptAll() {
    print('Accepting all');
    var al = requests;
    requests.forEach((key, value) {
      al[key] = true;
    });
    return copyWith(requests: al);
  }

  RequestAccessState denyAll() {
    print('Denying all');
    var al = requests;
    requests.forEach((key, value) {
      al[key] = false;
    });
    return copyWith(requests: al);
  }

  RequestAccessState copyWith({
    Map<String, bool?>? requests,
  }) {
    return RequestAccessState(
      requests: requests ?? this.requests,
    );
  }

  @override
  List<Object> get props => [requests, tStamp];

  @override
  String toString() => 'RequestAccessState(requests: $requests)';
}
