import 'package:flutter/material.dart';

// ignore: camel_case_types
class backButton extends StatelessWidget {
  const backButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.of(context).pop(),
      child: Image.asset(
        "assets/images/icons/Back.png",
        scale: 3,
      ),
    );
  }
}
