import 'package:babble/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {

  final _formKey = GlobalKey<FormState>();

  var newPassword = " ";

  final newPasswordController = TextEditingController();

  @override
  void dispose() {
    newPasswordController.dispose();
    super.dispose();
  }

  final currentUser = FirebaseAuth.instance.currentUser;

  changePassword() async{
    try{
      await currentUser!.updatePassword(newPassword);
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(context , MaterialPageRoute(builder: (context) => LoginPage()));

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.blueGrey,
        content: Text("Password has been changed",
          style: TextStyle(
            fontSize: 18,
            color: Colors.amber,
          ),
        ),
      ));
    }on FirebaseAuthException catch(error){

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20 , horizontal: 25),
          child: ListView(
            children: [
              SizedBox(height: 100,),
              Padding(padding: EdgeInsets.all(10),
                child: Image.asset("assets/images/change.jpg"),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: TextFormField(
                  autofocus: false,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "New Password",
                    hintText: "Enter new password",
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(
                        color: Colors.black26,
                        fontSize: 15

                    ),

                  ),
                  controller: newPasswordController,
                  validator: (value){
                    if (value == null || value.isEmpty){
                      return "Please enter email";
                    }
                    return null ;
                  },
                ),
              ),

              ElevatedButton(onPressed: (){
                if(_formKey.currentState!.validate()){
                  setState(() {
                    newPassword = newPasswordController.text;
                  });
                  changePassword();
                }
              },
                  child: Text("Change Password",
                  style: TextStyle(
                    fontSize: 18
                  ),))
            ],
          ),
        ),
      ),
    );
  }
}
