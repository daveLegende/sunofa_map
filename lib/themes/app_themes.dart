import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color primaryColor = Color(0xff0C97B5);
  static const Color black = Colors.black;
  static const Color white = Colors.white;
  //
  static const Color complementaryColor = Color(0xFFFFA45B); // Orange clair
  static const Color complementaryHover = Color.fromARGB(255, 248, 233, 219); // Orange clair
  static Color lightPrimary = primaryColor.withOpacity(.1); // Bleu clair
  static const Color mintGreen = Color(0xFF4DD0E1); // Vert menthe
  static const Color lightGray = Color(0xFFF2F2F2); // Gris clair
  static const Color background = Color.fromARGB(255, 209, 240, 248);
  static const Color red = Color.fromARGB(255, 189, 4, 4); // Blanc cassé

  static Color grey = Colors.grey.shade200;
  static const String fontFamilyLato = "Lato";
  static const String fontFamilyQuick = "Quicksand";

  TextStyle stylish1(double size, Color color, {bool isBold = false}) {
    return GoogleFonts.aBeeZee(
      fontSize: size,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      color: color,
    );
  }

  TextStyle stylish2(double size, Color color, {bool isBold = false}) {
    return GoogleFonts.comfortaa(
      fontSize: size,
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      color: color,
    );
  }

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    primaryColor: primaryColor,
    fontFamily: fontFamilyQuick,
  );
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    primaryColor: primaryColor,
    fontFamily: fontFamilyQuick,
  );
}
