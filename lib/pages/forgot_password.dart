import 'package:babble/pages/login_page.dart';
import 'package:babble/pages/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {

  final _formKey = GlobalKey<FormState>();
  var email = "";
  final emailController = TextEditingController();

  resetPassword() async {


    try{
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: email );
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.blueGrey,
        content: Text("Password reset email has been sent",
          style: TextStyle(
            fontSize: 18,

          ),
        ),
      ));
      Navigator.pushReplacement(context , MaterialPageRoute(builder: (context) => LoginPage()));
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

    }


  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(" Reset Password "),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
              padding: EdgeInsets.all(10),
            child: Image.asset("assets/images/forget.jpg",height: 200,),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
                "Reset link will ge set to your email",
              style: TextStyle(
                fontSize: 20
              ),
            ),

          ),
          Expanded(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20 , horizontal: 30),
                  child: ListView(
                    children: [
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
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(onPressed: (){
                              if (_formKey.currentState!.validate()){
                                setState(() {
                                  email = emailController.text;
                                });
                                resetPassword();
                              }
                            },
                                child: Text("send email" ,
                                style: TextStyle(fontSize: 18),
                                )),
                            TextButton(onPressed: (){
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                            },
                                child: Text("Login" ,
                                style: TextStyle(
                                  fontSize: 13,
                                ),)
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Do not have an account"),
                            TextButton(onPressed: (){
                              Navigator.pushAndRemoveUntil(context, PageRouteBuilder(
                                  pageBuilder: (context,a,b) => SignUp() ,
                                  transitionDuration: Duration(seconds: 0)), (route) => false);
                            },
                                child: Text("Sign up ")),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
          ),

        ],
      ),
    );
  }
}
