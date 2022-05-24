import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';
import '../logic/cubit/authenticator_cubit.dart';
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
            print(unattended.length);
            if (unattended.isEmpty) {
              context.read<AuthenticatorCubit>().clearRequests();
              Navigator.pop(context);
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
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: primaryColor,
                    width: 2,
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
                          print('Building request list');
                          return ListView.builder(
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
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(6),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.34),
                                      blurRadius: 4,
                                      offset: const Offset(2, 2),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      key,
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.normal,
                                        letterSpacing: .5,
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      color: Colors.white,
                                      onPressed: () => context
                                          .read<RequestAccessCubit>()
                                          .denyAccess(key),
                                      icon: const Icon(Icons.close),
                                    ),
                                    const SizedBox(width: 5),
                                    IconButton(
                                      color: Colors.white,
                                      onPressed: () => context
                                          .read<RequestAccessCubit>()
                                          .grantAccess(key),
                                      icon: const Icon(Icons.check),
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
