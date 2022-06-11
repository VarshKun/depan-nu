import 'package:depan_nu/auth/google_sign_in.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
class social_media_google extends StatelessWidget {
  const social_media_google({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        final provider =
            Provider.of<GoogleSignInProvider>(context, listen: false);
        provider.googleLogin();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 86,
            height: 58,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              boxShadow: const [
                BoxShadow(
                  color: Color(0xffb7cce0),
                  blurRadius: 2,
                  offset: Offset(-2, -2),
                ),
                BoxShadow(
                  color: Color(0xffffffff),
                  blurRadius: 0,
                  offset: Offset(-1, -1),
                ),
              ],
              color: const Color(0xfff1f5f9),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      width: 43.75,
                      height: 45.62,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
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
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: Image.asset(
                        "assets/images/icons/Google.png",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
