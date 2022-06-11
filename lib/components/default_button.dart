import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    Key? key,
    this.text,
    this.press,
  }) : super(key: key);
  final String? text;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 90,
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all<Color>(Colors.transparent),
        ),
        onPressed: press as void Function()?,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 165,
              height: 42,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xffffffff),
                    blurRadius: 16,
                    offset: Offset(-8, -8),
                  ),
                  BoxShadow(
                    color: Color(0xffc9d8e8),
                    blurRadius: 16,
                    offset: Offset(8, 8),
                  ),
                ],
                color: const Color(0xfff1f5f9),
              ),
              padding: const EdgeInsets.only(
                top: 7,
                bottom: 8,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 99,
                    height: 27,
                    child: Text(
                      text!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xff0a003d),
                        fontSize: 24,
                        fontFamily: "Lato",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
