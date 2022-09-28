import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QueueButton extends StatelessWidget {
  final Widget? switcher;
  final String subTitle;
  final IconData iconLabel;
  final String tileTitle;
  final Color? iconColor;
  const QueueButton({
    Key? key,
    this.switcher,
    required this.subTitle,
    required this.iconLabel,
    required this.tileTitle,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: ListTile(
        title: Text(
          tileTitle,
          style: GoogleFonts.varelaRound(
            fontSize: 14,
            fontWeight: FontWeight.w300,
          ),
        ),
        trailing: switcher,
        subtitle: Text(subTitle),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
    );
  }
}
