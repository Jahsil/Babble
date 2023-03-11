import 'package:babble/user/change_password.dart';
import 'package:babble/user/dashboard.dart';
import 'package:babble/user/profile.dart';
import 'package:flutter/material.dart';


class UserMain extends StatefulWidget {
  const UserMain({Key? key}) : super(key: key);

  @override
  _UserMainState createState() => _UserMainState();
}

class _UserMainState extends State<UserMain> {

  int selectedIndex = 0 ;

  static List<Widget> widgetOptions = <Widget>[
    DashBoard(),
    Profile(),
    ChangePassword(),
  ];

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widgetOptions.elementAt(selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
            label: "Dashboard",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Change Password",
          ),
        ],
        currentIndex: selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: onItemTapped,
      ),
    );
  }
}
