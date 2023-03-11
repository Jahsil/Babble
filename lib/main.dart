import 'package:babble/pages/login_page.dart';
import 'package:babble/pages/screens/splash_screen.dart';
import 'package:babble/provider/internet_provider.dart';
import 'package:babble/provider/sign_in_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:babble/pages/welcome/view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: ((context) => SignInProvider()),
      ),
      ChangeNotifierProvider(
        create: ((context) => InternetProvider()),
      ),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/welcome' : (context) => WelcomePage(),
          '/login' : (context) => LoginPage(),
          '/' : (context) => SplashScreen(),

        }
      ),
  ),
  );
}





