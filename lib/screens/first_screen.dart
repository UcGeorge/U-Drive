import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logic/cubit/server_cubit.dart';

import '../logic/cubit/root_navigator_cubit.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.read<ServerCubit>().start();
            context.read<RootNavigatorCubit>().goHome(context);
          },
          child: const Text('Start Server'),
        ),
      ),
    );
  }
}
