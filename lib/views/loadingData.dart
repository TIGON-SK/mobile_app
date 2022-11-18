import 'package:flutter/material.dart';
import 'package:library_app/api/book_data.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:library_app/views/home.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setUpBooks() async {
    //BooksApi instance = BooksApi();
    //await instance.fetchBooks(token);
  }

  @override
  void initState() {
    super.initState();
    setUpBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();// widget tree
  }
}