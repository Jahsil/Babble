import 'package:flutter/material.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 100, 50, 100),
          child: Column(
            children: [
              CircleAvatar(
                radius: 150,
                backgroundImage: AssetImage("assets/images/intro3.gif"),
              ),
              SizedBox(height: 50,),
              Text("End to End encrypted"),
            ],
          ),
        ),
      ),

    );
  }
}
