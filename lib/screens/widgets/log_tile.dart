import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../constants/general.dart';
import '../../data/models/server_log.dart';

class LogTile extends StatelessWidget {
  const LogTile({
    Key? key,
    required this.log,
  }) : super(key: key);

  final ServerLog log;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            height: 25,
            width: 130,
            decoration: BoxDecoration(
              color: log.type == LogType.serverMessage
                  ? Colors.orange.withOpacity(.2)
                  : log.type == LogType.probe
                      ? Colors.blue.withOpacity(.2)
                      : log.type == LogType.warning
                          ? Colors.red.withOpacity(.2)
                          : Colors.green.withOpacity(.2),
              borderRadius: BorderRadius.circular(200),
            ),
            child: Center(
              child: Text(
                log.type == LogType.serverMessage
                    ? 'SERVER MESSAGE'
                    : log.type == LogType.probe
                        ? 'PROBE'
                        : log.type == LogType.warning
                            ? 'WARNING'
                            : 'NETWORK REQUEST',
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                  color: log.type == LogType.serverMessage
                      ? Colors.orange
                      : log.type == LogType.probe
                          ? Colors.blue
                          : log.type == LogType.warning
                              ? Colors.red
                              : Colors.green,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Text(
            log.message,
            style: GoogleFonts.poppins(
              fontSize: 14,
              // fontWeight: FontWeight.w600,
              // letterSpacing: 1,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          Text(
            '${log.timeStamp.hour}:${log.timeStamp.minute}:${log.timeStamp.second} - ${log.timeStamp.day} ${months[log.timeStamp.month]}, ${log.timeStamp.year}',
            style: GoogleFonts.poppins(
              fontSize: 11,
              letterSpacing: 1,
              color: Colors.black.withOpacity(.7),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }
}
