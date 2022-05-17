import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/cubit/ma_navigator_cubit.dart';
import '../../logic/cubit/root_navigator_cubit.dart';
import '../../logic/cubit/server_cubit.dart';
import '../../logic/src/navigators/navigator_interface.dart';

class MenuBar extends StatelessWidget {
  final AppNavigator navigator;
  final MiniAppNavCubit navigatorCubit;

  const MenuBar({
    Key? key,
    required this.navigator,
    required this.navigatorCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: const Color(0xff0D1724).withOpacity(0.2),
            blurRadius: 10,
            // offset: const Offset(6, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ElevatedButton(
            style: ButtonStyle(
              fixedSize: MaterialStateProperty.all<Size>(
                const Size(200, 40),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                  // borderRadius: BorderRadius.only(
                  //   topLeft: Radius.circular(10),
                  //   topRight: Radius.circular(10),
                  // ),
                ),
              ),
            ),
            onPressed: () {
              context.read<RootNavigatorCubit>().gotoFirstPage(context);
              context.read<ServerCubit>().end();
            },
            child: const Text('EXIT'),
          ),
        ],
      ),
    );
  }
}
