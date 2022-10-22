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
    BooksApi instance = BooksApi();
    await instance.fetchBooks();
    //Navigator.pushNamed(context, "/home",arguments: {"books" :instance.booksFetched});

    // Navigator.push(context, ,arguments: {
    //   "books":instance.booksFetched});
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Home(instance.booksFetched)));
  }

  @override
  void initState() {
    super.initState();
    print("AAa");
    setUpBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[900],
        body: Center(
            child: SpinKitPouringHourglass(
          color: Colors.white,
          size: 50.0,
        )));
  }
}
