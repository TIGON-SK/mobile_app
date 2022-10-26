import 'package:flutter/material.dart';
import 'package:library_app/views/home.dart';
import 'package:library_app/views/loadingData.dart';
import 'package:library_app/views/login.dart';

void main() => runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      //'/': (context) => Loading(),
      '/login': (context) => Login(),
      '/home': (context) => Home(),
       '/authors': (context) => ,
       '/genres': (context) => ,
    }
)
);