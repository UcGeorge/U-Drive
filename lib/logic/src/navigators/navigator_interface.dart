import 'package:flutter/material.dart';

abstract class AppNavigator {
  Route<dynamic> onGenerateRoute(RouteSettings settings);
}
