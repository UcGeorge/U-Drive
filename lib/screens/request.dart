import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../logic/cubit/authenticator_cubit.dart';
import '../logic/cubit/ma_navigator_cubit.dart';
import '../logic/cubit/request_access_cubit.dart';

class RequestPopup extends StatelessWidget {
  const RequestPopup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context2) {
        return BlocListener<RequestAccessCubit, RequestAccessState>(
          listener: (_, state) {
            var unattended =
                state.requests.values.where((element) => element == null);
            // print(unattended.length);
            if (unattended.isEmpty) {
              context.read<AuthenticatorCubit>().clearRequests();
              Navigator.pop(context);
              context.read<MiniAppNavCubit>().showServerClients(context, false);
            }
          },
          child: Card(
            elevation: 0,
            color: Colors.transparent,
            child: Center(
              child: Container(
                height: 600,
                width: 500,
                decoration: BoxDecoration(
                  color: const Color(0xffFBFCFE),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: const Color(0xffFBFCFE),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.34),
                      blurRadius: 12,
                      offset: const Offset(4, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        // color: primaryColor[200],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6),
                          topRight: Radius.circular(6),
                        ),
                      ),
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed:
                                context.read<RequestAccessCubit>().denyAll,
                            child: const Text('Deny all'),
                          ),
                          Text(
                            'Connection Requests',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              letterSpacing: .5,
                            ),
                          ),
                          TextButton(
                            onPressed:
                                context.read<RequestAccessCubit>().acceptAll,
                            child: const Text('Accept all'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child:
                          BlocBuilder<RequestAccessCubit, RequestAccessState>(
                        builder: (_, state) {
                          // print('Building request list');
                          return ListView.builder(
                            controller: ScrollController(),
                            shrinkWrap: true,
                            itemCount: state.requests.keys
                                .where((element) =>
                                    state.requests[element] == null)
                                .length,
                            itemBuilder: (_, index) {
                              String key = state.requests.keys
                                  .where((element) =>
                                      state.requests[element] == null)
                                  .toList()[index];
                              return Container(
                                height: 50,
                                width: double.infinity,
                                margin: const EdgeInsets.all(4),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: const Color(0xffF5F6FA),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      key,
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        letterSpacing: .5,
                                      ),
                                    ),
                                    const Spacer(),
                                    TextButton(
                                      onPressed: () => context
                                          .read<RequestAccessCubit>()
                                          .denyAccess(key),
                                      child: const Text('deny'),
                                      style: ButtonStyle(
                                        overlayColor:
                                            MaterialStateProperty.all<Color?>(
                                          Colors.red.withOpacity(.1),
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color?>(
                                          Colors.white,
                                        ),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            side: const BorderSide(
                                              color: Colors.red,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color?>(
                                          Colors.red,
                                        ),
                                        textStyle: MaterialStateProperty.all<
                                            TextStyle>(
                                          GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            letterSpacing: .5,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    TextButton(
                                      onPressed: () => context
                                          .read<RequestAccessCubit>()
                                          .grantAccess(key),
                                      child: const Text('accept'),
                                      style: ButtonStyle(
                                        overlayColor:
                                            MaterialStateProperty.all<Color?>(
                                          Colors.green.withOpacity(.1),
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color?>(
                                          Colors.white,
                                        ),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            side: const BorderSide(
                                              color: Colors.green,
                                              width: 1,
                                            ),
                                          ),
                                        ),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color?>(
                                          Colors.green,
                                        ),
                                        textStyle: MaterialStateProperty.all<
                                            TextStyle>(
                                          GoogleFonts.poppins(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            letterSpacing: .5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
