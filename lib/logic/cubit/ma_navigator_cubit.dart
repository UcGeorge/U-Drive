import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../screens/request.dart';
import '../../screens/server_clients.dart';
import '../../screens/server_screen.dart';
import 'navigator_cubit.dart';

class MiniAppNavCubit extends NavigatorCubit {
  MiniAppNavCubit(AppNavigator navigator, String initialRoute)
      : super(navigator, initialRoute);

  void showLogs(BuildContext context, [bool? push, bool? pop]) => navigateTo(
        context,
        'logs${push ?? true ? '' : '-inter'}',
        push,
        pop,
      );
  void launchClient(BuildContext context, [bool? push, bool? pop]) =>
      navigateTo(
        context,
        'client${push ?? true ? '' : '-inter'}',
        push,
        pop,
      );
  void showRequests(BuildContext context, [bool? push, bool? pop]) =>
      navigateTo(
        context,
        'requests${push ?? true ? '' : '-inter'}',
        push,
        pop,
      );
  void showServerClients(BuildContext context, [bool? push, bool? pop]) =>
      navigateTo(
        context,
        'server-clients${push ?? true ? '' : '-inter'}',
        push,
        pop,
      );
}

class MiniAppNavigator implements AppNavigator {
  @override
  Route onGenerateRoute(RouteSettings settings) {
    var path = settings.name;

    switch (path) {
      case 'logs':
        return _logsRoute();
      case 'requests':
        return _requestsRoute();
      case 'server-clients':
        return _serverClientsRoute();
      default:
        return _logsRoute();
    }
  }

  Route _serverClientsRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const ServerClientsScreen(),
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

  Route _requestsRoute() {
    return PageRouteBuilder(
      barrierDismissible: false,
      barrierColor: primaryColor.withOpacity(.3),
      fullscreenDialog: false,
      opaque: false,
      pageBuilder: (
        context,
        animation,
        secondaryAnimation,
      ) =>
          const RequestPopup(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = 0.0;
        const end = 1.0;
        const curve = Curves.ease;

        Animatable<double> tween = Tween(
          begin: begin,
          end: end,
        ).chain(CurveTween(curve: curve));

        return ScaleTransition(
          scale: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Route _logsRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const ServerScreen(),
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
