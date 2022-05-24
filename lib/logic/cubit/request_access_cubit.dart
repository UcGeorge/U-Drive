import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'request_access_state.dart';

class RequestAccessCubit extends Cubit<RequestAccessState> {
  RequestAccessCubit() : super(RequestAccessState.init());

  void requestAccess(String name) => emit(state.withNewRequest(name));
  void grantAccess(String name) => emit(state.accept(name));
  void denyAccess(String name) => emit(state.deny(name));
  void acceptAll() => emit(state.acceptAll());
  void denyAll() => emit(state.denyAll());
  void clear() => emit(state.copyWith(requests: {}));
}
