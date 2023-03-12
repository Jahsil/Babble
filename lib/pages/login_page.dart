
import 'package:babble/pages/forgot_password.dart';
import 'package:babble/pages/login_controller.dart';
import 'package:babble/pages/sign_up.dart';
import 'package:babble/pages/user_main.dart';
import 'package:babble/user/dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import 'package:google_sign_in/google_sign_in.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _formKey = GlobalKey<FormState>();



  var email = " ";
  var password = " ";

  final emailController = TextEditingController();
  final passwordController = TextEditingController();




  // googleLoginUI(){
  //   isUsingEmail = false;
  //   return Consumer<ControllerLogin>(
  //       builder: (context , model , child){
  //         if (model.userDetailsModel != null){
  //
  //           return Center(
  //             child: Text("hellow world"),
  //
  //           );
  //
  //         }
  //         else{
  //           return notLoggedInScreen();
  //         }
  //       }
  //   );
  // }




  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(LoginController());
    late bool isUsingEmail ;




    userLogin() async{

      try{
        isUsingEmail = true;
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email, password: password);
        Navigator.pushReplacement(context , MaterialPageRoute(
          builder: (context) => UserMain(),
          settings: RouteSettings(
            arguments: isUsingEmail,
          )
        ));
      }on FirebaseAuthException catch(error){
        if(error.code == "user-not-found"){
          print("no user found for the email");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.blueGrey,
            content: Text("no user found for the email",
              style: TextStyle(
                fontSize: 18,
                color: Colors.amber,
              ),
            ),
          ));
        }
        else if(error.code == 'wrong-password')
        {
          print("wrong password providded by the user");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.blueGrey,
            content: Text("wrong password providded by the user",
              style: TextStyle(
                fontSize: 18,
                color: Colors.amber,
              ),
            ),
          ));
        }
      }
    }






    googleLoginButton(){
      return Container(
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                isUsingEmail = false;
                await controller.login();
                Navigator.push(context,  MaterialPageRoute(
                builder: (context) => UserMain(),
                  settings: RouteSettings(
                    arguments: isUsingEmail,
                  )


      ));
              },
              child: Image.asset("assets/images/google.png" , width: 250,),
            )
          ],
        ),
      );
    }


    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/images/login.jpg"),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: "email",
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(
                        color: Colors.black26,
                      fontSize: 15

                    ),

                  ),
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
                margin: EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  autofocus: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(
                        color: Colors.black26,
                        fontSize: 15

                    ),

                  ),
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
                      onPressed: (){
                        if(_formKey.currentState!.validate()){
                          setState(() {
                            email = emailController.text;
                            password = passwordController.text;
                          });
                          isUsingEmail = true;
                          userLogin();
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


              googleLoginButton(),





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
              )
            ],
          ),
        ),
      ),
    );
  }

}









































