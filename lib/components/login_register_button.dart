import 'package:flutter/material.dart';

// ignore: camel_case_types
class login_register_button extends StatelessWidget {
  const login_register_button({
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
      height: 60,
      child: TextButton(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all<Color>(
              const Color.fromARGB(255, 226, 229, 231)),
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
                    color: Color(0xff8486d1),
                    blurRadius: 16,
                    offset: Offset(8, 8),
                  ),
                ],
                color: const Color(0xff3c42e0),
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
                        color: Color(0xfff1f5f9),
                        fontSize: 23,
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
