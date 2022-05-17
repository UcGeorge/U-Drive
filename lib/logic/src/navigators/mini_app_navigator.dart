import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../screens/server_screen.dart';
import '../../cubit/server_cubit.dart';
import 'navigator_interface.dart';

class MiniAppNavigator implements AppNavigator {
  @override
  Route onGenerateRoute(RouteSettings settings) {
    var path = settings.name;

    switch (path) {
      case 'server':
        return _serverRoute();
      default:
        return _serverRoute();
    }
  }

  Route _serverRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          BlocProvider.value(
        value: context.read<ServerCubit>(),
        child: const ServerScreen(),
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
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
