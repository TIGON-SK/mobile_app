import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:library_app/api/book_data.dart';
import 'package:library_app/views/loadingData.dart';
import 'package:library_app/views/widgets/navigation.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  List booksList = [];
  bool loadingInProgress = true;
  Future<List> setUpBooks() async {
    BooksApi instance = BooksApi();
    await instance.fetchBooks();
    booksList= instance.booksFetched;
    return booksList;
  }

  @override
  Widget build(BuildContext context) {

    if(ModalRoute.of(context)?.settings.arguments!=null){
      Map m = ModalRoute.of(context)!.settings.arguments as Map;
      loadingInProgress=m['loadingInProgress'];
      booksList=m['fetchedBooks'];
    }
    if (loadingInProgress) {
      checkForNewBooks();
      return Scaffold(
          backgroundColor: Colors.blue[900],
          body: Center(
              child: SpinKitPouringHourglass(
            color: Colors.white,
            size: 50.0,
          )));
    } else {
      return Scaffold(
          appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text('Knižnica'),
              actions: <Widget>[]),
          body: Container(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(50.0),
                child: Column(
                  children: [
                    Text("Knihy",
                        style: TextStyle(
                            fontSize: 30.0, fontWeight: FontWeight.bold)),
                    ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: booksList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                              child: Padding(
                            padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                            child: Column(
                              children: [
                                Text("${booksList[index].id}"),
                                Text("${booksList[index].title}"),
                              ],
                            ),
                          ));
                        }),
                  ],
                ),
              ),
            ),
          ));
    }
  }

  checkForNewBooks(){
    WidgetsBinding.instance.addPostFrameCallback((_) async {
    if(booksList.isEmpty){
      print("niesu knihy");
      List temp = await setUpBooks();
      loadingInProgress=false;
      Navigator.pushNamed(context, '/home',arguments: {
        "loadingInProgress" :loadingInProgress,"fetchedBooks":temp
      });
    }
    else{
      loadingInProgress=false;
      print("su knihy");
      Navigator.pushNamed(context, '/home',arguments: {
        "loadingInProgress" :loadingInProgress,"fetchedBooks":booksList
      });
    }
    });
  }
}

// TODO: implement build
