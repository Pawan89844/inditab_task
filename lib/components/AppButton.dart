// ignore_for_file: file_names

import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final String name;
  final void Function()? onPressed;
  final Color? color;
  final bool isLoading;
  const AppButton({
    Key? key,
    required this.name,
    required this.onPressed,
    this.isLoading = false,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          fixedSize: MaterialStateProperty.all(
              Size(isLoading ? 30.0 : size.width * .5, 40.0)),
          animationDuration: const Duration(milliseconds: 300),
          elevation: MaterialStateProperty.all(isLoading ? 0.0 : null),
          backgroundColor:
              MaterialStateProperty.all(isLoading ? Colors.white : color),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
              borderRadius: isLoading
                  ? BorderRadius.circular(30.0)
                  : BorderRadius.circular(12.0)))),
      child: isLoading
          ? const SizedBox(
              height: 20.0,
              width: 20.0,
              child: CircularProgressIndicator(
                  // color: Colors.white,
                  ))
          : Text(name),
    );
  }
}
