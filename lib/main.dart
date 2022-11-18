import 'package:flutter/material.dart';
import 'package:library_app/views/home.dart';
import 'package:library_app/views/loadingData.dart';
import 'package:library_app/views/login.dart';
import 'package:library_app/views/register.dart';

void main() => runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      //'/': (context) => Loading(),
      '/register': (context) => Register(),
      '/login': (context) => Login(),
      '/home': (context) => Home(),
       //'/authors': (context) => ,
       //'/genres': (context) => ,
    }
)
);