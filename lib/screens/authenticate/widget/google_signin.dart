import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../services/auth.dart';

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({super.key});

  @override
  State<GoogleSignInButton> createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  final AuthService _auth = AuthService();
  bool isSignIn = false;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return isSignIn
        ? SpinKitThreeBounce(
           color: Colors.amber[700],
           
        )
        : SizedBox(
            width: width * 0.55,
            height: height * 0.06,
            child: ElevatedButton(
              onPressed: () async {
                setState(() {
                  isSignIn = true;
                });
                _auth.signInGoogle();
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  backgroundColor: Colors.white),
              child: Row(
                children: [
                  SizedBox(
                    width: width * 0.1,
                    child: Image.asset("assets/googleLogo.png"),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: width * 0.02),
                    child: const Text(
                      "Entrar com Google",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 53, 61, 66),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
