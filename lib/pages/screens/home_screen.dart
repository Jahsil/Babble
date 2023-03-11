import 'package:babble/pages/screens/login_screen.dart';
import 'package:babble/provider/sign_in_provider.dart';
import 'package:babble/utils/next_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override


  Widget build(BuildContext context) {

    final sp = context.read<SignInProvider>();




    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            sp.userSignOUt();
            nextScreenReplace(context, const LoginScreen());
          },
          child: Text("Sign out"),
        ),
      ),
    );
  }
}
