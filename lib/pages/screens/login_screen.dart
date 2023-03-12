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

import '../forgot_password.dart';
import '../sign_up.dart';

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

  final _formKey = GlobalKey<FormState>();

  var email = " ";
  var password = " ";

  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body:
          Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //SizedBox(height: 50,),
                  Image(
                    image: AssetImage("assets/images/logo.png"),
                    height: 150,
                    width: 150,
                    //fit: BoxFit.cover,
                  ),

                   Text("Welcome to Babble",
                      style:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.w500)),
                   SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Please Sign in ",
                    style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                  ),

                  SizedBox(height: 10,),

                  Form(
                    key:_formKey,
                    child: Expanded(
                      child: ListView(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 30),
                              child: TextFormField(
                                autofocus: false,
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.email_outlined),
                                    hintText: "Enter your email",
                                    hintStyle: TextStyle(color: Colors.grey[600]),
                                    errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(color: Colors.red)),
                                    focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(color: Colors.grey)),
                                    enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: const BorderSide(color: Colors.grey))),
                                controller: emailController,
                                validator: (value){
                                  if (value == null || value.isEmpty){
                                    return "Please enter email";
                                  }else if (!value.contains("@")){
                                    return "Please enter a valid email";
                                  }
                                  return null ;
                                },
                              ),

                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10 , horizontal: 30),
                            child: TextFormField(
                              autofocus: false,
                              obscureText: true,
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.key),
                                  hintText: "Enter your password",
                                  hintStyle: TextStyle(color: Colors.grey[600]),
                                  errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(color: Colors.red)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(color: Colors.grey)),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(color: Colors.grey))),
                              controller: passwordController,
                              validator: (value){
                                if (value == null || value.isEmpty){
                                  return "Please enter password";
                                }
                                return null ;
                              },
                            ),
                          ),

                          Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll<Color>(Colors.indigo),
                                  ) ,
                                  onPressed: (){
                                    if(_formKey.currentState!.validate()){
                                      setState(() {
                                        email = emailController.text;
                                        password = passwordController.text;
                                      });


                                    }
                                  },
                                  child: Text(
                                    'login',
                                    style: TextStyle(
                                      fontSize: 18 ,
                                    ),
                                  ),
                                ),
                                TextButton(onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => ForgotPassword(),));
                                },
                                  child: Text(
                                    'Forget Password',
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Dont have an account ? "),
                                TextButton(onPressed: (){
                                  // Navigator.pushAndRemoveUntil(context, PageRouteBuilder(
                                  //   pageBuilder: (context,a,b) => SignUp(),transitionDuration: Duration(seconds: 10)),
                                  //         (route) => false);
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) => SignUp(),));
                                },
                                    child: Text("sign up" )
                                )
                              ],
                            ),
                          ),

                          Container(
                            child: RoundedLoadingButton(
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


                          ),

                          SizedBox(height: 10,),

                          Container(
                            child: RoundedLoadingButton(
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

                          ),


                        ],
                      ),


                    ),

                  ),






                    ],


              ),


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
