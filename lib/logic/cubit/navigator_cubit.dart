import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'navigator_state.dart';

class NavigatorCubit extends Cubit<NavigatorState> {
  final AppNavigator navigator;
  NavigatorCubit(this.navigator) : super(NavigatorInitial());

  void navigateTo(BuildContext context, String path) =>
      Navigator.of(context).pushNamed(path);
}

abstract class AppNavigator {
  Route<dynamic> onGenerateRoute(RouteSettings settings);
}
