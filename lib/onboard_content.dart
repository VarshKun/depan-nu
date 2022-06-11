import 'package:flutter/material.dart';

class OnboardContent extends StatelessWidget {
  const OnboardContent({
    Key? key,
    this.text,
    this.image,
  }) : super(key: key);
  final String? text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 100,
        ),
        //const Spacer(),
        Image.asset(
          image!,
          width: 266,
          height: 243,
        ),
        const SizedBox(
          height: 50,
        ),
        Text(
          text!,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFF020435),
            fontSize: 32,
            fontFamily: 'Lato',
          ),
        ),
      ],
    );
  }
}
