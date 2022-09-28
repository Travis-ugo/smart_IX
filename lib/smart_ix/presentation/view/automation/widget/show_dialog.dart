import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future showDialogFrame(
  BuildContext context, {
  required Function(String value) onChanged,
  required Function() onTap,
}) =>
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          titleTextStyle: GoogleFonts.varelaRound(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w200,
          ),
          backgroundColor: Colors.grey[900],
          title: const Text("Routine name"),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          content: TextField(
            key: const Key('routine_tag_textField'),
            onChanged: onChanged,
            style: GoogleFonts.varelaRound(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w200,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: false,
              hintStyle: GoogleFonts.varelaRound(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.w200,
              ),
              hintText: 'add routine name',
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                "Cancel",
                style: GoogleFonts.varelaRound(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w200,
                ),
              ),
              onPressed: () {
                Navigator.of(context, rootNavigator: true).pop();
              },
            ),
            TextButton(
              onPressed: onTap,
              child: Text(
                "Ok",
                style: GoogleFonts.varelaRound(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w200,
                ),
              ),
            ),
          ],
        );
      },
    );
