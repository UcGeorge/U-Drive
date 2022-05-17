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
        boxShadow: [
          BoxShadow(
            color: const Color(0xff0D1724).withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(5, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            height: 40,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: log.type == LogType.serverMessage
                  ? Colors.orange
                  : log.type == LogType.probe
                      ? Colors.blue
                      : log.type == LogType.warning
                          ? Colors.red
                          : Colors.green,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
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
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Text(
            log.message,
            style: GoogleFonts.poppins(
              fontSize: 16,
              // fontWeight: FontWeight.w600,
              // letterSpacing: 1,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          Text(
            '${log.timeStamp.hour}:${log.timeStamp.minute}:${log.timeStamp.second} - ${log.timeStamp.day} ${months[log.timeStamp.month]}, ${log.timeStamp.year}',
            style: GoogleFonts.poppins(
              fontSize: 16,
              letterSpacing: 1,
              color: Colors.black.withOpacity(.5),
            ),
          ),
          const SizedBox(width: 20),
          Container(
            height: 40,
            width: 5,
            decoration: BoxDecoration(
              color: log.type == LogType.serverMessage
                  ? Colors.orange
                  : log.type == LogType.probe
                      ? Colors.blue
                      : log.type == LogType.warning
                          ? Colors.red
                          : Colors.green,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
