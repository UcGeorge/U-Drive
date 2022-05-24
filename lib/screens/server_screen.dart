import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/colors.dart';
import '../logic/cubit/server_cubit.dart';
import 'widgets/log_tile.dart';
import 'widgets/server_screen_template.dart';

class ServerScreen extends ServerScreenTemplate {
  const ServerScreen({Key? key}) : super(key: key);

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
                  Icons.wrap_text_rounded,
                  size: 24,
                  color: primaryColor,
                ),
                const SizedBox(width: 10),
                Text(
                  'Logs',
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: .5,
                    color: Colors.indigo,
                  ),
                ),
                const Spacer(),
                TextButton(
                  onPressed: context.read<ServerCubit>().clearLogs,
                  child: const Text('clear logs'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: const Color(0xffF5F6FA),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: BlocBuilder<ServerCubit, ServerState>(
                  builder: (context, state) {
                    return ListView.builder(
                      controller:
                          context.read<ServerCubit>().logsScrollController,
                      itemCount: state.logs.length,
                      itemBuilder: (context, index) =>
                          LogTile(log: state.logs[index]),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
