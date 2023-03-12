import 'package:babble/pages/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  var email = "";
  var password = "";
  var confirmPassword = "";

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


      Navigator.pushReplacement(context , MaterialPageRoute(builder: (context) => LoginScreen()));
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
              Image(
                image: AssetImage("assets/images/logo.png"),
                height: 150,
                width: 150,
                //fit: BoxFit.cover,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Sign Up to Babble",
                      style:
                      TextStyle(
                        color: Colors.indigo,
                          fontSize: 25,
                          fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Please Sign up using your email and password ",
                    style: TextStyle(fontSize: 15, color: Colors.grey[600]),
                  ),

                  SizedBox(height: 10,),
                ],
              ),



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
                margin: EdgeInsets.symmetric(vertical: 10),
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
                margin: EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  autofocus: false,
                  obscureText: true,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.key),
                      hintText: "Confirm your Password",
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
                      style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(Colors.indigo),
                      ) ,
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
                          pageBuilder: (context, animation1, animation2) => LoginScreen(),
                          transitionDuration: Duration(seconds: 0 ))
                      );
                    },
                        child: Text("Login" ,
                        style: TextStyle(
                          color: Colors.indigo,
                        ),)
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
