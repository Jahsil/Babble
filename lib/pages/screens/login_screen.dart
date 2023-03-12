import 'package:babble/pages/screens/home_screen.dart';
import 'package:babble/pages/screens/phone_auth.dart';
import 'package:babble/provider/internet_provider.dart';
import 'package:babble/provider/sign_in_provider.dart';
import 'package:babble/utils/next_screen.dart';
import 'package:babble/utils/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  final RoundedLoadingButtonController googleController =
      RoundedLoadingButtonController();
  final RoundedLoadingButtonController phoneController =
  RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
            padding:
            const EdgeInsets.only(left: 40, right: 40, top: 90, bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flexible(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image(
                        image: AssetImage("assets/images/login.jpg"),
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text("Welcome to Babble",
                          style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Please Sign in ",
                        style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                      )
                    ],
                  ),
                ),

                // roundedbutton
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RoundedLoadingButton(
                      onPressed: () {
                        handleGoogleSignIn();
                      },
                      controller: googleController,
                      successColor: Colors.red,
                      width: MediaQuery.of(context).size.width * 0.80,
                      elevation: 0,
                      borderRadius: 25,
                      color: Colors.red,
                      child: Wrap(
                        children: const [
                          Icon(
                            FontAwesomeIcons.google,
                            size: 20,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text("Sign in with Google",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    RoundedLoadingButton(
                      onPressed: () {
                        nextScreen(context, PhoneAuth());
                        phoneController.reset();

                      },
                      controller: phoneController,
                      successColor: Colors.black54,
                      width: MediaQuery.of(context).size.width * 0.80,
                      elevation: 0,
                      borderRadius: 25,
                      color: Colors.black54,
                      child: Wrap(
                        children: const [
                          Icon(
                            FontAwesomeIcons.phone,
                            size: 20,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text("Sign in with Phone Number",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),



                    const SizedBox(
                      height: 10,
                    ),

                    // phoneAuth loading button

                  ],
                )
              ],
            ),
          )),
    );
  }

  Future handleGoogleSignIn () async {
    final sp = context.read<SignInProvider>();
    final ip = context.read<InternetProvider>();
    await ip.checkInternetConnection();

    if (ip.hasInternet == false) {
      openSnackBar(context, "Check your Internet connection", Colors.red);
      googleController.reset();
    } else {
      await sp.signInWithGoogle().then((value) {
        if (sp.hasError == true) {
          openSnackBar(context, sp.errorCode.toString(), Colors.red);
          googleController.reset();
        } else {
          // checking whether user exists or not
          sp.checkUserExists().then((value) async {
            if (value == true) {
              // user exists
              await sp.getUserDataFromFirestore(sp.uid).then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                googleController.success();
                handleAfterSignIn();
              })));
            } else {
              // user does not exist
              sp.saveDataToFirestore().then((value) => sp
                  .saveDataToSharedPreferences()
                  .then((value) => sp.setSignIn().then((value) {
                googleController.success();
                handleAfterSignIn();
              })));
            }
          });
        }
      });
    }
  }

  handleAfterSignIn() {
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      nextScreenReplace(context, const HomeScreen());
    });
  }


}
