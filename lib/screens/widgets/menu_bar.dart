import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/colors.dart';
import '../../logic/cubit/ma_navigator_cubit.dart';
import '../../logic/cubit/navigator_cubit.dart' as na;
import '../../logic/cubit/root_navigator_cubit.dart';
import '../../logic/cubit/server_cubit.dart';

class MenuBar extends StatelessWidget {
  const MenuBar({Key? key}) : super(key: key);

  bool isServer(String s) =>
      s == 'logs' || s == 'requests' || s == 'server-clients';
  bool isLogs(String s) => s == 'logs';
  bool isRequests(String s) => s == 'requests';
  bool isServetClients(String s) => s == 'server-clients';
  bool isClients(String s) => s == 'clients';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      buildWhen: ((_previous, _current) {
        var previous = _previous as na.NavigatorState;
        var current = _current as na.NavigatorState;

        return previous.currentRoute != current.currentRoute &&
            (!current.currentRoute.contains('-inter'));
      }),
      bloc: context.read<MiniAppNavCubit>(),
      builder: (context, _state) {
        var state = _state as na.NavigatorState;
        String route = state.currentRoute;
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
                    : () => context
                        .read<MiniAppNavCubit>()
                        .showServerClients(context),
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
                  onTap: isServetClients(route) || isRequests(route)
                      ? null
                      : () => context
                          .read<MiniAppNavCubit>()
                          .showServerClients(context, false),
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
                  onTap: isLogs(route) || isRequests(route)
                      ? null
                      : () => context
                          .read<MiniAppNavCubit>()
                          .showLogs(context, false),
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
                onTap: isClients(route) || isRequests(route) ? null : () {},
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
      },
    );
  }
}
