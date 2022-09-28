import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final theme = ThemeData(
  primarySwatch: Colors.grey,
  primaryColorDark: const Color(0xFF121212),
  primaryColor: Colors.grey,
  primaryColorLight: const Color(0xFF121212),
  backgroundColor: const Color(0xFF212121),
  scaffoldBackgroundColor: const Color(0xFF121212),
  primaryTextTheme: const TextTheme(bodyText2: TextStyle(color: Colors.white)),
  dividerColor: Colors.grey[300],
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: Colors.grey[500]),
    filled: true,
    fillColor: Colors.grey[900],
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: const BorderSide(
        color: Colors.blue,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: const BorderSide(
        color: Color.fromRGBO(117, 117, 117, 1),
        width: 2.0,
      ),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20.0),
    ),
  ),
  textTheme: GoogleFonts.varelaRoundTextTheme(
    const TextTheme(
      headline1: TextStyle(height: 2, color: Colors.white),
      headline2: TextStyle(height: 2, color: Colors.white),
      headline3: TextStyle(height: 2, color: Colors.white),
      headline4: TextStyle(height: 2, color: Colors.white),
      headline5: TextStyle(height: 2, color: Colors.white),
      headline6: TextStyle(height: 2, color: Colors.white),
      subtitle1: TextStyle(height: 2, color: Colors.white),
      subtitle2: TextStyle(height: 2, color: Colors.white),
      bodyText1: TextStyle(height: 2, color: Colors.white),
      bodyText2: TextStyle(height: 2, color: Colors.white),
      caption: TextStyle(height: 2, color: Colors.white),
      button: TextStyle(height: 2, color: Colors.white),
      overline: TextStyle(height: 2, color: Colors.white),
    ),
  ),
);
