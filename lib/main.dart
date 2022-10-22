import 'package:flutter/material.dart';
import 'package:library_app/views/home.dart';
import 'package:library_app/views/loadingData.dart';
import 'package:library_app/views/login.dart';

void main() => runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Loading(),
      //'/home': (context) => Home(booksList),
      // '/authors': (context) => ,
      // '/genres': (context) => ,
    }
)
);