import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Config {
  static const String title = "Islamic Radio";
  static const String share_msg = "Listen to Islamic radio ";
  static const String share_subject =
      "Listen to many Islamic Radio channels all over the world";

  static ThemeData themeOptions(BuildContext context) {
    return ThemeData(
      primaryColor: Color(0xFF263241),
      accentColor: Color(0xFF413f6A),
      primaryTextTheme: GoogleFonts.montserratTextTheme(
        Theme.of(context).textTheme,
      ),
      textTheme: GoogleFonts.montserratTextTheme(
        Theme.of(context).textTheme,
      ),
    );
  }

  static Decoration backgroundGradient() {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        stops: [0.5, 1.3],
        colors: [
          Color(0xFF263241),
          Color(0xFF413f6A),
        ],
      ),
    );
  }
}
