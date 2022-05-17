import 'package:flutter/cupertino.dart';

import '../src/navigators/navigator_interface.dart';
import 'navigator_cubit.dart';

class MiniAppNavCubit extends NavigatorCubit {
  MiniAppNavCubit(AppNavigator navigator) : super(navigator);

  void launchServer(BuildContext context) => navigateTo(context, 'server');
  void launchClient(BuildContext context) => navigateTo(context, 'client');
}
