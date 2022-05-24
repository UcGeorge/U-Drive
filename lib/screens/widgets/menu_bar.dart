import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/colors.dart';
import '../../logic/cubit/ma_navigator_cubit.dart';
import '../../logic/cubit/navigator_cubit.dart';
import '../../logic/cubit/root_navigator_cubit.dart';
import '../../logic/cubit/server_cubit.dart';

class MenuBar extends StatefulWidget {
  final AppNavigator navigator;
  final MiniAppNavCubit navigatorCubit;

  const MenuBar({
    Key? key,
    required this.navigator,
    required this.navigatorCubit,
  }) : super(key: key);

  @override
  State<MenuBar> createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {
  bool isServer(String s) =>
      s == 'logs' || s == 'requests' || s == 'server-clients';
  bool isLogs(String s) => s == 'logs';
  bool isClients(String s) => s == 'clients';
  bool isServetClients(String s) => s == 'server-clients';

  @override
  Widget build(BuildContext context) {
    String route = context.watch<MiniAppNavCubit>().state.currentRoute;
    print('menu route: $route');
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
        // mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 50),
          const Divider(),
          ListTile(
            selected: isServer(route),
            selectedColor: primaryColor,
            selectedTileColor: primaryColor.withOpacity(.25),
            // tileColor: primaryColor.withOpacity(.25),
            onTap: isServer(route)
                ? null
                : () => widget.navigatorCubit.showLogs(context),
            dense: true,
            leading: const Icon(
              Icons.file_copy_rounded,
              size: 20,
            ),
            title: Text(
              'Server',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                letterSpacing: .5,
              ),
            ),
            visualDensity: VisualDensity.compact,
          ),
          Visibility(
            visible: isServer(route),
            child: ListTile(
              contentPadding: const EdgeInsets.only(left: 40),
              selected: isServetClients(route),
              selectedColor: primaryColor,
              selectedTileColor: primaryColor.withOpacity(.25),
              // tileColor: primaryColor.withOpacity(.25),
              onTap: isServetClients(route)
                  ? null
                  : () =>
                      widget.navigatorCubit.showServerClients(context, false),
              dense: true,
              leading: const Icon(
                Icons.people_alt_rounded,
                size: 18,
              ),
              title: Text(
                'Clients',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  letterSpacing: .5,
                ),
              ),
              visualDensity: VisualDensity.compact,
            ),
          ),
          Visibility(
            visible: isServer(route),
            child: ListTile(
              contentPadding: const EdgeInsets.only(left: 40),
              selected: isLogs(route),
              selectedColor: primaryColor,
              selectedTileColor: primaryColor.withOpacity(.25),
              onTap: isLogs(route)
                  ? null
                  : () => widget.navigatorCubit.showLogs(context, false),
              dense: true,
              leading: const Icon(
                Icons.wrap_text_rounded,
                size: 18,
              ),
              title: Text(
                'Logs',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  letterSpacing: .5,
                ),
              ),
              visualDensity: VisualDensity.compact,
            ),
          ),
          const Divider(),
          ListTile(
            selected: !isServer(route),
            selectedColor: primaryColor,
            selectedTileColor: primaryColor.withOpacity(.25),
            // tileColor: primaryColor.withOpacity(.25),
            onTap: () {},
            dense: true,
            leading: const Icon(
              Icons.drive_file_move_rounded,
              size: 20,
            ),
            title: Text(
              'Drive',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                letterSpacing: .5,
              ),
            ),
            visualDensity: VisualDensity.compact,
          ),
          const Spacer(),
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
