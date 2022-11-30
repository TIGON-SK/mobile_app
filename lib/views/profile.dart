import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:library_app/api/book_data.dart';
import 'package:library_app/api/user_token.dart';
import 'package:library_app/views/loadingData.dart';
import 'package:library_app/views/register.dart';
import 'package:library_app/views/screenArguments.dart';
import 'package:library_app/views/widgets/navigation.dart';

import 'explore.dart';
import 'login.dart';

class Profile extends StatefulWidget {
  Map map = {};
  Profile(this.map);
  @override
  ProfileState createState() => ProfileState(map);
}

class ProfileState extends State<Profile> {
  Map map = {};
  ProfileState(this.map);
  @override
  Widget build(BuildContext context) {


    return Scaffold(
        body: Column(
            children: [
              Text("Profil"),Text("Profil"),Text(map.toString()),
            ]));

  }
}