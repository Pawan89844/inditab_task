// ignore_for_file: file_names
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Utils {
  static OutlineInputBorder kDefaultBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.grey));

  static Text appText(String text,
          {Color? color, double? fontSize, FontWeight? fontWeight}) =>
      Text(text,
          style: GoogleFonts.montserrat(
              color: color, fontSize: fontSize, fontWeight: fontWeight));
}
