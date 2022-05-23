import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../screens/server_screen.dart';
import 'navigator_cubit.dart';
import 'server_cubit.dart';

class MiniAppNavCubit extends NavigatorCubit {
  MiniAppNavCubit(AppNavigator navigator) : super(navigator);

  void launchServer(BuildContext context) => navigateTo(context, 'server');
  void launchClient(BuildContext context) => navigateTo(context, 'client');
}

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
