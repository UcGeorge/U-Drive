import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/cubit/ma_navigator_cubit.dart';
import '../logic/cubit/navigator_cubit.dart';
import 'mini_app/root.dart';
import 'widgets/menu_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String initialRoute;
  late AppNavigator minAppNav;
  late MiniAppNavCubit minAppNavCubit;

  @override
  void initState() {
    super.initState();
    initialRoute = 'server-clients';
    minAppNav = MiniAppNavigator();
    minAppNavCubit = MiniAppNavCubit(minAppNav, initialRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Row(
                  children: [
                    const SizedBox(width: 200),
                    Expanded(
                      child: MiniAppRoot(
                        initialRoute,
                        navigator: minAppNav,
                        navigatorCubit: minAppNavCubit,
                      ),
                    ),
                  ],
                ),
                BlocProvider.value(
                  value: minAppNavCubit,
                  child: const MenuBar(),
                ),
              ],
            ),
          ),
          Container(
            height: 20,
            width: double.infinity,
            color: Colors.indigo,
          ),
        ],
      ),
    );
  }
}
