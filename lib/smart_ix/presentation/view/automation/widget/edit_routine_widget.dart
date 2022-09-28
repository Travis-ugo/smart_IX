// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditBlock extends StatelessWidget {
  final Function() onTap;
  final String subTitle;
  final String tag;
  final IconData iconLabel;
  final String tileTitle;
  final Color? iconColor;
  final Widget? switcher;

  const EditBlock({
    Key? key,
    required this.onTap,
    required this.subTitle,
    required this.tag,
    required this.iconLabel,
    required this.tileTitle,
    this.iconColor,
    this.switcher,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tag,
            style: GoogleFonts.varelaRound(
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            onTap: onTap,
            title: Text(
              tileTitle,
              style: GoogleFonts.varelaRound(
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
            trailing: switcher,
            subtitle: Text(subTitle),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            tileColor: Colors.grey[900],
            leading: Icon(
              iconLabel,
              size: 30,
              color: iconColor ?? Colors.blue,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ],
      ),
    );
  }
}

class EditRoutineName extends StatelessWidget {
  const EditRoutineName({
    Key? key,
    required this.initial,
    required this.onChanged,
  }) : super(key: key);

  final String initial;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      child: Column(
        children: [
          const Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Routine name',
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 15),
          TextFormField(
            initialValue: initial,
            onChanged: onChanged,
            style: const TextStyle(fontSize: 22),
            decoration: const InputDecoration(border: InputBorder.none),
          ),
        ],
      ),
    );
  }
}
