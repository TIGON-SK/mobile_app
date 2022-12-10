import 'package:flutter/material.dart';
import 'package:library_app/views/explore.dart';
import 'package:library_app/views/loadingData.dart';
import 'package:library_app/views/login.dart';

void main() => runApp(MaterialApp(
    initialRoute: '/login',
    routes: {
      '/login': (context) => Login(),
    }
)
);