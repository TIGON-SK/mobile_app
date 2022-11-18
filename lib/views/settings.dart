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

    return Scaffold(
        body: Column(
          children: [
            Text("Nastavenia"),Text("Nastavenia"),Text("Nastavenia"),
  ]));

  }
}