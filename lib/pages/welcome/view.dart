import 'package:babble/pages/welcome/intro_page1.dart';
import 'package:babble/pages/welcome/intro_page2.dart';
import 'package:babble/pages/welcome/intro_page3.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../login_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  final PageController _controller = PageController();
  bool isFinalPage = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index){
              setState(() {
                if (index == 2){
                  print(index);
                  isFinalPage = true;
                }else{
                  isFinalPage = false;
                }
              });
            },
            children: [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          Container(
            alignment: Alignment(0 , 0.75),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: (){
                      _controller.jumpToPage(2);
                    },
                    child: Text("Skip"),
                  ),

                  SmoothPageIndicator(
                    controller: _controller,
                    count: 3,
                    effect: WormEffect(),
                  ),
                  isFinalPage ?
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return LoginPage();
                      }));

                    },
                    child: Text("Done"),
                  ):GestureDetector(
                    onTap: (){
                      _controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                    },
                    child: Text("Next"),
                  )

                ],
              ),
          )
        ],
      )
    );
  }
}
