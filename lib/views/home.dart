import 'package:flutter/material.dart';
import 'package:library_app/api/book_data.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:Padding(
        padding:const EdgeInsets.only(top:50.0),
        child:TextButton(onPressed: () {
          BookData bookData = new BookData();
          print(bookData.getBooks());
        }, child: Text("Ahoj")),
      ),
    );
  }
}