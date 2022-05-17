import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';

import '../logic/cubit/server_cubit.dart';
import 'widgets/log_tile.dart';

class ServerScreen extends StatelessWidget {
  const ServerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Server logs',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                letterSpacing: .5,
                color: Colors.indigo,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Neumorphic(
                style: NeumorphicStyle(
                  shape: NeumorphicShape.concave,
                  boxShape:
                      NeumorphicBoxShape.roundRect(BorderRadius.circular(10)),
                  depth: -5,
                  lightSource: LightSource.topLeft,
                  color: Colors.grey[100],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
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
            ),
          ],
        ),
      ),
    );
  }
}
