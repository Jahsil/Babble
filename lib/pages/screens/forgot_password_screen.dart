import 'package:babble/pages/screens/login_screen.dart';
import 'package:babble/pages/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

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
      Navigator.pushReplacement(context , MaterialPageRoute(builder: (context) => LoginScreen()));
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
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
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
                color: Colors.indigo,
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
                        margin: EdgeInsets.symmetric(vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                                style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll<Color>(Colors.indigo),
                                ) ,
                                onPressed: (){
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
                                  builder: (context) => LoginScreen()));
                            },
                                child: Text("Login" ,
                                  style: TextStyle(
                                    color: Colors.indigo,
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
                                  pageBuilder: (context,a,b) => SignUpScreen() ,
                                  transitionDuration: Duration(seconds: 0)), (route) => false);
                            },
                                child: Text("Sign up ",
                                style: TextStyle(
                                  color: Colors.indigo,
                                ),)),

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
