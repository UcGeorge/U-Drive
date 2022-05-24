import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../logic/cubit/ma_navigator_cubit.dart';
import '../logic/cubit/navigator_cubit.dart';
import 'mini_app/root.dart';
import 'widgets/menu_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String initialRoute = 'server-clients';
    AppNavigator minAppNav = MiniAppNavigator();
    MiniAppNavCubit minAppNavCubit = MiniAppNavCubit(minAppNav, initialRoute);

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
                  child: MenuBar(
                    navigator: minAppNav,
                    navigatorCubit: minAppNavCubit,
                  ),
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
