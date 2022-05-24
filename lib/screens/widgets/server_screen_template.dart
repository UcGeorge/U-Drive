import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import '/../../logic/cubit/navigator_cubit.dart' as na;
import '../../logic/cubit/authenticator_cubit.dart';
import '../../logic/cubit/ma_navigator_cubit.dart';

abstract class ServerScreenTemplate extends StatelessWidget {
  const ServerScreenTemplate({Key? key}) : super(key: key);

  Widget buildPage(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return BlocListener<MiniAppNavCubit, na.NavigatorState>(
      listener: (_, state) {
        switch (state.currentRoute) {
          case 'logs-inter':
            context.read<MiniAppNavCubit>().showLogs(context, true, true);
            break;
          case 'server-clients-inter':
            context
                .read<MiniAppNavCubit>()
                .showServerClients(context, true, true);
            break;
          default:
            break;
        }
      },
      child: BlocListener<AuthenticatorCubit, AuthenticatorState>(
        listenWhen: (previous, current) =>
            current.accessRequested != previous.accessRequested &&
            !previous.accessRequested,
        listener: (_context, state) =>
            context.read<MiniAppNavCubit>().showRequests(context),
        child: buildPage(context),
      ),
    );
  }
}
