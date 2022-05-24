part of 'navigator_cubit.dart';

class NavigatorState extends Equatable {
  final String currentRoute;

  const NavigatorState({
    required this.currentRoute,
  });

  NavigatorState copyWith({
    String? currentRoute,
  }) {
    return NavigatorState(
      currentRoute: currentRoute ?? this.currentRoute,
    );
  }

  @override
  String toString() => 'NavigatorState(currentRoute: $currentRoute)';

  @override
  List<Object> get props => [currentRoute];
}
