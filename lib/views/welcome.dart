import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:library_app/api/book_data.dart';
import 'package:library_app/api/user_token.dart';
import 'package:library_app/views/loadingData.dart';
import 'package:library_app/views/register.dart';
import 'package:library_app/views/screenArguments.dart';
import 'package:library_app/views/widgets/navigation.dart';

import 'home.dart';
import 'login.dart';

class Welcome extends StatefulWidget {
  @override
  WelcomeState createState() => WelcomeState();
}

class WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    int _currentIndex = 0;
    final List _children = [
      HomeState(),
      
    ];

    void onTabTapped(int index) {
      setState(() {
        _currentIndex = index;
      });
    }

    final data = ModalRoute
        .of(context)!
        .settings
        .arguments as ScreenArguments;
    //final args = ModalRoute.of(context)!.settings.arguments as UserWithToken;
    Map dataWToken = {};
    // if (data.arguments == null)
    //   dataWToken = "empty";
    // else
    //   dataWToken = data.arguments as String;
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //   //setstate?
    //
    //
    // });
    setState(() {
      dataWToken = data.data as Map;
      dataWToken['token']=data.token;
      dataWToken['firstStart']=false;
    });
    return Scaffold(
      body: Column(
        children: [
          Text("Ahoj! ${dataWToken['name']}"),
          Text("Token: ${dataWToken['token']}"),
          TextButton(
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                    builder: (context) => Home(),
                    settings: RouteSettings(
                      arguments: dataWToken,
                    )),
              );
            },
            child: Text("Zobrazit knihy"),
          )
        ],
      ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex,
          items: [
            new BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.person),
              label: "Profile",
            ),
            new BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.home),
              label: "Home",
            ),
            new BottomNavigationBarItem(
              backgroundColor: Colors.white,
              icon: Icon(Icons.book),
              label: "Books",
            ),
          ],
        )
    );
  }
}