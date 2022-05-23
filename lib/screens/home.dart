import 'package:flutter/material.dart';

import '../logic/cubit/ma_navigator_cubit.dart';
import '../logic/cubit/navigator_cubit.dart';
import 'mini_app/root.dart';
import 'widgets/menu_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppNavigator minAppNav = MiniAppNavigator();
    MiniAppNavCubit minAppNavCubit = MiniAppNavCubit(minAppNav);

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
                        'server',
                        navigator: minAppNav,
                        navigatorCubit: minAppNavCubit,
                      ),
                    )
                  ],
                ),
                MenuBar(
                  navigator: minAppNav,
                  navigatorCubit: minAppNavCubit,
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
