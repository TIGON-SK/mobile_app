import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:library_app/api/book_data.dart';
import 'package:library_app/api/user_token.dart';
import 'package:library_app/views/loadingData.dart';
import 'package:library_app/views/profile.dart';
import 'package:library_app/views/register.dart';
import 'package:library_app/views/screenArguments.dart';
import 'package:library_app/views/settings.dart';
import 'package:library_app/views/widgets/navigation.dart';

import 'explore.dart';
import 'login.dart';
import 'logout.dart';

class Welcome extends StatefulWidget {
  Map map = {};
  Welcome(this.map);

  @override
  WelcomeState createState() => WelcomeState(map);
}

class WelcomeState extends State<Welcome> {
  Map map = {};
  WelcomeState(this.map);
  int _selectedIndex = 0;


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  //Future<List> bookList;
  bool loading = true;
  bool filledParams=false;
  @override
  Widget build(BuildContext context) {
    final List _widgetOptions = [
      Settings(map),
      Profile(map),
      //emptyParams
      Explore(map, loading, filledParams),
      Logout(),
    ];
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.settings,color: Colors.blueGrey),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: Colors.blueGrey),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.travel_explore,color: Colors.blueGrey),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout,color: Colors.blueGrey),
            label: 'Log out',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueGrey,
        onTap: _onItemTapped,
      ),
    );
  }
}