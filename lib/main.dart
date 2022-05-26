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

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late String initialRoute;
  late AppNavigator navigator;
  late RootNavigatorCubit _rootNavigator;

  @override
  void initState() {
    super.initState();
    initialRoute = 'first';
    navigator = RootNavigator();
    _rootNavigator = RootNavigatorCubit(navigator, initialRoute);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: ((context) => _rootNavigator),
          lazy: false,
        ),
        BlocProvider(
          create: ((context) => ServerCubit(KServer(
                name: 'UcGeorge',
                public: false,
              ))),
          lazy: true,
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'U-Drive',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xffFBFCFE),
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
