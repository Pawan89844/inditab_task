// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/AppText.dart';

class AppInputField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final bool obscureText;
  const AppInputField(
      {Key? key, this.labelText, this.controller, this.obscureText = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: (value) => value!.isEmpty ? 'Field can\'t be empty' : null,
      decoration: InputDecoration(
        isDense: true,
        border: Utils.kDefaultBorder,
        errorBorder: Utils.kDefaultBorder,
        enabledBorder: Utils.kDefaultBorder,
        focusedBorder: Utils.kDefaultBorder,
        disabledBorder: Utils.kDefaultBorder,
        focusedErrorBorder: Utils.kDefaultBorder,
        labelText: labelText,
        labelStyle: GoogleFonts.montserrat(),
      ),
    );
  }
}
