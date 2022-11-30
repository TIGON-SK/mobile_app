import 'package:flutter/material.dart';
import 'package:library_app/views/explore.dart';
import 'package:library_app/views/loadingData.dart';
import 'package:library_app/views/login.dart';
import 'package:library_app/views/register.dart';

void main() => runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/register': (context) => Register(),
      '/login': (context) => Login(),
    }
)
);