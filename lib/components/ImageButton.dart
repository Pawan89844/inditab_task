// ignore_for_file: file_names
import 'package:flutter/material.dart';
import '../utils/AppText.dart';

class ImageButton extends StatelessWidget {
  final String imagePath;
  final String buttonName;
  final void Function()? onTap;
  const ImageButton(
      {Key? key,
      required this.imagePath,
      required this.onTap,
      required this.buttonName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 45.0,
            child: Card(
              shape: const StadiumBorder(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      height: 30.0,
                      alignment: Alignment.center,
                      child: Image.asset(imagePath)),
                  const SizedBox(width: 10.0),
                  Utils.appText(
                    buttonName,
                    fontWeight: FontWeight.w700,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
