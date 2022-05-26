import 'package:clipboard/clipboard.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';
import '../logic/classes/client.dart';
import '../logic/cubit/authenticator_cubit.dart';
import '../logic/cubit/server_cubit.dart';
import 'widgets/server_screen_template.dart';

class ServerClientsScreen extends ServerScreenTemplate {
  const ServerClientsScreen({Key? key}) : super(key: key);

  @override
  Widget buildPage(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFBFCFE),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.people_alt_rounded,
                  size: 24,
                  color: primaryColor,
                ),
                const SizedBox(width: 10),
                Text(
                  'Clients',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: .5,
                    color: Colors.indigo,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: context.read<AuthenticatorCubit>().clear,
                  child: const Text('Revoke all'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: BlocBuilder<AuthenticatorCubit, AuthenticatorState>(
                builder: (context, state) {
                  return ListView.builder(
                    itemCount: state.authorizedClients.length,
                    itemBuilder: (context, index) {
                      String token =
                          state.authorizedClients.keys.toList()[index];
                      Client client = state.authorizedClients[token]!;
                      return Container(
                        // height: 100,
                        width: double.infinity,
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: const Color(0xffF5F6FA),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          title: Text(
                            client.name,
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                              letterSpacing: .5,
                            ),
                          ),
                          subtitle: Text.rich(
                            TextSpan(
                              text: 'Access Token: ',
                              style: GoogleFonts.poppins(
                                color: primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                letterSpacing: .5,
                              ),
                              children: <InlineSpan>[
                                TextSpan(
                                  text: client.token,
                                  style: GoogleFonts.spaceMono(
                                    color: Colors.black.withOpacity(.5),
                                  ),
                                ),
                                WidgetSpan(
                                  baseline: TextBaseline.alphabetic,
                                  alignment: PlaceholderAlignment.middle,
                                  child: InkWell(
                                    onTap: () =>
                                        FlutterClipboard.copy(client.token),
                                    child: const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 4.0),
                                      child: Icon(
                                        Icons.copy,
                                        color: primaryColor,
                                        size: 14,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          trailing: TextButton(
                            onPressed: () => context
                                .read<AuthenticatorCubit>()
                                .removeClient(token),
                            child: const Text('Revoke Access'),
                            style: ButtonStyle(
                              overlayColor: MaterialStateProperty.all<Color?>(
                                Colors.red.withOpacity(.1),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.all<Color?>(
                                Colors.white,
                              ),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
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
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                const EdgeInsets.all(10),
                              ),
                              textStyle: MaterialStateProperty.all<TextStyle>(
                                GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal,
                                  letterSpacing: .5,
                                ),
                              ),
                            ),
                          ),
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
    );
  }
}
