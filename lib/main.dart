import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'data/models/api_server.dart';
import 'logic/cubit/navigator_cubit.dart';
import 'logic/cubit/root_navigator_cubit.dart';
import 'logic/cubit/server_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AppNavigator navigator = RootNavigator();
    RootNavigatorCubit _rootNavigator = RootNavigatorCubit(navigator);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: ((context) => _rootNavigator),
          lazy: false,
        ),
        BlocProvider(
          create: ((context) => ServerCubit(KServer(
                name: 'UcGeorge',
                public: true,
              ))),
          lazy: true,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'U-Drive',
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
        initialRoute: 'first',
      ),
    );
  }
}
