import 'package:babble/pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../pages/login_controller.dart';



class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {




  final uid = FirebaseAuth.instance.currentUser!.uid;
  final email = FirebaseAuth.instance.currentUser!.email;
  final creationTime = FirebaseAuth.instance.currentUser!.metadata.creationTime;

  User? user = FirebaseAuth.instance.currentUser;

  verifyEmail() async {
    if (user != null && user!.emailVerified){
      await user!.sendEmailVerification();
      print("verificatoin email has been sent ");

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.blueGrey,
        content: Text("verificatoin email has been sent",
          style: TextStyle(
            fontSize: 18,
            color: Colors.amber,
          ),
        ),
      ));
    }
  }

  //
  // googleLoginUI(){
  //
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
  //           return alreadyLoggedInScreen (model);
  //         }
  //       }
  //   );
  // }





  // googleLoginUIProfile() {
  //   return Consumer<ControllerLogin>(
  //       builder: (context, model, child) {
  //         if (model.userDetailsModel != null) {
  //           return Center(
  //             child: alreadyLoggedInScreen(model),
  //           );
  //         }else{
  //           return Center(
  //             child: signedInWithEmail(),
  //           );
  //         }
  //       }
  //   );
  // }


  signedInWithEmail(){
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20 , vertical: 60),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: Image.asset("assets/images/profile.png"),
            ),

            SizedBox(height: 50,),

            Column(
              children: [
                Text(
                  "user ID",
                  style: TextStyle(fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),

                ),
                Text(
                  uid,
                  style: TextStyle(fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),

                ),
              ],
            ),
            SizedBox(height: 50,),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Email : ${email}",
                  style: TextStyle(fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),

                ),

                user!.emailVerified ? Text(
                  'Verified',
                  style: TextStyle(
                    fontSize: 22 ,
                    color: Colors.lightBlue,
                  ),
                ) :
                TextButton(onPressed: (){
                  verifyEmail();

                },
                    child: Text(
                      "Verify Email",
                      style: TextStyle(fontSize: 22,
                        color: Colors.lightBlue,
                      ),

                    )
                ),
              ],
            ),

            SizedBox(height: 50,),

            Column(
              children: [
                Text(
                  "Created",
                  style: TextStyle(fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),


                ),
                Text(
                  creationTime.toString(),
                  style: TextStyle(fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),

                )
              ],
            ),
            SizedBox(height: 50,),
            ElevatedButton(onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                  builder: (context) => LoginPage()), (route) => false);
            },
                child: Text(
                  "Logout",
                  style: TextStyle(fontSize: 18,

                  ),

                )
            ),
          ],
        ),
      ),
    );
  }


  alreadyLoggedInScreen(){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,

      children: [
        CircleAvatar(
          backgroundImage: AssetImage("assets/images/profile.png"),
          radius: 100,
        ),

        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.person,
              color: Colors.black,
            ),
            SizedBox(height: 20,),
            Text(
              "Eyouel",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                  color: Colors.black
              ),
            )
          ],
        ),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.email,
              color: Colors.black,
            ),
            SizedBox(height: 20,),
            Text(
              "abysine@aoeij.com",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black
              ),
            )
          ],
        ),
        SizedBox(height: 30),



      ],
    );

  }


  @override
  Widget build(BuildContext context) {

    final state = ModalRoute.of(context)!.settings.arguments;

    print("==================== STATE ==================");
    print(state);

    final controller = Get.put(LoginController());


    return Center(
      child: Obx((){
        if(controller.googleAccount.value == null){
          return Center(
            child: Text("Not logged in using google"),
          );
        }else{
          return signedInWithEmail();

        }
      }),
    );
  }
}
