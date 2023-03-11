import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Container(

          child: Center(
            child: CircleAvatar(
              radius: 150,
              child: Image.asset("assets/images/logo-black.png"),
            )
          ),
        ),
      ),
    );
  }
}
