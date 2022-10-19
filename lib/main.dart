import 'package:flutter/material.dart';
import 'package:library_app/views/home.dart';
import 'package:library_app/views/login.dart';


void main() => runApp(MaterialApp(
    initialRoute: '/home',
    routes: {
      '/': (context) => Login(),
      '/home': (context) => Home(),
      // '/authors': (context) => ,
      // '/genres': (context) => ,
    }
)
);