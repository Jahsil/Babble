import 'package:babble/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'forgot_password.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final _formKey = GlobalKey<FormState>();
  var email = "";
  var password = "";
  var confirmPassword = "";

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  registration() async {
    if(password == confirmPassword){
      try{ UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email, password: password);
      print(userCredential);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.blueGrey,
        content: Text("Registered Successfully , Please Sign in",
          style: TextStyle(
            fontSize: 18,
            color: Colors.amber,
          ),
        ),
      ));


        Navigator.pushReplacement(context , MaterialPageRoute(builder: (context) => LoginPage()));
      }on FirebaseAuthException catch(error){
        if(error.code == "weak-password"){
          print("Password is too weak");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.blueGrey,
            content: Text("Password is too weak",
              style: TextStyle(
                fontSize: 18,
                color: Colors.amberAccent,
              ),
            ),
          ));
        }
        else if(error.code == 'email-already-in-use')
        {
          print("Account already exists");
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.blueGrey,
            content: Text("Account already exists",
              style: TextStyle(
                fontSize: 18,
                color: Colors.amber,
              ),
            ),
          ));
        }
      }
    }
    else{
      print("passwords don't match");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.blueGrey,
        content: Text("Passwords don't match",
          style: TextStyle(
            fontSize: 18,
            color: Colors.amber,
          ),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/images/signup.png"),
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
                margin: EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  autofocus: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(
                        color: Colors.black26,
                        fontSize: 15

                    ),

                  ),
                  controller: confirmPasswordController,
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return "Please confirm  password";
                    }
                    return null ;
                  },
                ),
              ),
              SizedBox(height: 15,),

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
                            confirmPassword = confirmPasswordController.text;
                          });
                          registration();
                        }

                      },
                      child: Text(
                        'sign up',
                        style: TextStyle(
                          fontSize: 18 ,
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
                    Text("Already have an account ? "),
                    TextButton(onPressed: (){
                      // Navigator.pushAndRemoveUntil(context, PageRouteBuilder(
                      //   pageBuilder: (context,a,b) => SignUp(),transitionDuration: Duration(seconds: 10)),
                      //         (route) => false);
                      Navigator.pushReplacement(context, PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) => LoginPage(),
                          transitionDuration: Duration(seconds: 0 ))
                      );
                    },
                        child: Text("Login" )
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
