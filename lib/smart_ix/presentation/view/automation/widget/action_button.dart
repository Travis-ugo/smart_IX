// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ActionsButton extends StatelessWidget {
  final Function() onTap;
  final String commandLabel;
  final String tileTitle;

  const ActionsButton({
    Key? key,
    required this.onTap,
    required this.commandLabel,
    required this.tileTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tileTitle,
            style: GoogleFonts.varelaRound(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            onTap: onTap,
            title: Text(
              commandLabel,
              style: GoogleFonts.varelaRound(
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
            tileColor: Colors.grey[900],
            trailing: const Icon(
              Icons.add,
              size: 30,
              color: Colors.blue,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          )
        ],
      ),
    );
  }
}
