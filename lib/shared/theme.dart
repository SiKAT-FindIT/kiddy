import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color purpleColor = const Color(0xFF9491FF);
Color blueColor = const Color(0xFF61D5FC);
Color darkGreenColor = const Color(0xFF42B45F);
Color lightGreenColor = const Color(0xFFA9DC35);
Color darkYellowColor = const Color(0xFFF2E026);
Color lightYellowColor = const Color(0xFFFFF9A9);
Color darkPinkColor = const Color(0xFFFC95A8);
Color lightPinkColor = const Color(0xFFFFCFD5);
Color darkGreyColor = const Color(0xFF5E616A);
Color lightGreyColor = const Color(0xFA9DB2CE);
Color whiteColor = Colors.white;

List<BoxShadow> cardShadow = [
  BoxShadow(
    color: darkGreyColor.withOpacity(0.5),
    blurRadius: 16,
    spreadRadius: 0,
  ),
];

TextStyle purpleText = GoogleFonts.poppins(color: purpleColor);
TextStyle blueText = GoogleFonts.poppins(color: blueColor);
TextStyle darkGreenText = GoogleFonts.poppins(color: darkGreenColor);
TextStyle lightGreenText = GoogleFonts.poppins(color: lightGreenColor);
TextStyle darkYellowText = GoogleFonts.poppins(color: darkYellowColor);
TextStyle lightYellowText = GoogleFonts.poppins(color: lightYellowColor);
TextStyle darkPinkText = GoogleFonts.poppins(color: darkPinkColor);
TextStyle lightPinkText = GoogleFonts.poppins(color: lightPinkColor);
TextStyle darkGreyText = GoogleFonts.poppins(color: darkGreyColor);
TextStyle lighGreyText = GoogleFonts.poppins(color: lightGreyColor);
TextStyle whiteText = GoogleFonts.poppins(color: whiteColor);

FontWeight light = FontWeight.w300;
FontWeight regular = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semibold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
