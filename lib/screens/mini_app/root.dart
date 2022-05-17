import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../logic/cubit/ma_navigator_cubit.dart';
import '../../logic/src/navigators/navigator_interface.dart';

class MiniAppRoot extends StatelessWidget {
  final AppNavigator navigator;
  final MiniAppNavCubit navigatorCubit;
  final String initialRoute;

  const MiniAppRoot(
    this.initialRoute, {
    Key? key,
    required this.navigator,
    required this.navigatorCubit,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: ((context) => navigatorCubit),
          lazy: false,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: initialRoute,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.indigo,
          textTheme: TextTheme(
            button: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              letterSpacing: .5,
            ),
          ),
        ),
        onGenerateRoute: navigator.onGenerateRoute,
        initialRoute: initialRoute,
      ),
    );
  }
}
