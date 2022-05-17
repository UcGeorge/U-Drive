import 'package:flutter/cupertino.dart';

import '../src/navigators/navigator_interface.dart';
import 'navigator_cubit.dart';

class RootNavigatorCubit extends NavigatorCubit {
  RootNavigatorCubit(AppNavigator navigator) : super(navigator);

  void goHome(BuildContext context) => navigateTo(context, 'home');
  void gotoFirstPage(BuildContext context) => navigateTo(context, 'first');
}
