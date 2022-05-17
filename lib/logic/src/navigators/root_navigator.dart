import 'package:flutter/material.dart';
import 'package:u_drive/screens/home.dart';

import '../../../screens/first_screen.dart';
import 'navigator_interface.dart';

class RootNavigator implements AppNavigator {
  @override
  Route onGenerateRoute(RouteSettings settings) {
    var path = settings.name;

    switch (path) {
      case 'first':
        return _firstScreenRoute();
      case 'home':
        return _homeScreenRoute();
      default:
        return _firstScreenRoute();
    }
  }

  Route _firstScreenRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const FirstScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(-1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Route _homeScreenRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const HomeScreen(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
