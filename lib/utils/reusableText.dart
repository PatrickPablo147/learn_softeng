import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget reusableText(String text, Color color) {
  return Text(
    text,
    style: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: color
    ),
  );
}

Widget reusableCenterText(String text, Color color) {
  return Text(
    text,
    style: GoogleFonts.inter(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: color,
    ),
    textAlign: TextAlign.center,
  );
}

Widget reusableSubtitleText(String text, Color color) {
  return Text(
    text,
    style: GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: color,
    ),
  );
}

Widget reusableTitleText(String text, Color color) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: color,
        height: 1.2,
        letterSpacing: -0.5
      ),
    ),
  );
}
