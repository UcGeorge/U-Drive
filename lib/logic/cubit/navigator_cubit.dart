import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'navigator_state.dart';

class NavigatorCubit extends Cubit<NavigatorState> {
  final AppNavigator navigator;
  NavigatorCubit(this.navigator, String initialRoute)
      : super(NavigatorState(currentRoute: initialRoute));

  void navigateTo(BuildContext context, String path, [bool? push, bool? pop]) {
    var prevState = state;
    emit(state.copyWith(currentRoute: path));
    if (push ?? true) {
      if (pop ?? false) {
        print('popping "${prevState.currentRoute}"...');
        Navigator.of(context).popAndPushNamed(path);
      } else {
        Navigator.of(context).pushNamed(path);
      }
      print('pushing "${state.currentRoute}"...');
    } else {
      print('intermediary state: "${state.currentRoute}"...');
    }
    print(state);
  }
}

abstract class AppNavigator {
  Route<dynamic> onGenerateRoute(RouteSettings settings);
}
