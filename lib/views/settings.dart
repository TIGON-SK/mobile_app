import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:library_app/api/book_data.dart';
import 'package:library_app/api/user_token.dart';
import 'package:library_app/views/loadingData.dart';
import 'package:library_app/views/screenArguments.dart';
import 'package:library_app/views/widgets/navigation.dart';

import 'explore.dart';
import 'login.dart';

class Settings extends StatefulWidget {
  Map map = {};
  Settings(this.map);
  @override
  SettingsState createState() => SettingsState(map);
}

class SettingsState extends State<Settings> {
  Map map = {};
  SettingsState(this.map);
  @override
  Widget build(BuildContext context) {


    return Scaffold(
        body: Column(
          children: [
            Text("Nastavenia"),Text("Nastavenia"),Text(map.toString()),
  ]));

  }
}