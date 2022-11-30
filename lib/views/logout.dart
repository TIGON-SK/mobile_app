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

class Logout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_){
    Navigator.of(context).popUntil(ModalRoute.withName('/login'));
    });
    return Scaffold(
      body: Container(
        child: Text("Logging out..."),
      ),
    );
}
}