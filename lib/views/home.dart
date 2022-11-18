import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:library_app/api/book_data.dart';
import 'package:library_app/views/loadingData.dart';
import 'package:library_app/views/register.dart';
import 'package:library_app/views/screenArguments.dart';
import 'package:library_app/views/widgets/navigation.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  String token="";
  List booksList = [];
  //bool loadingInProgress = true;
  Map retriveString = {};
  Map dataWToken = {};

  bool began = false;

  Future<List> setUpBooks() async {
    BooksApi instance = BooksApi();
    //tu chyba!
    await instance.fetchBooks(token);
    booksList= instance.booksFetched;
    return booksList;
  }

  @override
  Widget build(BuildContext context) {
    if(ModalRoute.of(context)?.settings.arguments!=null){
      //first started lebo sa posielaju ine data za kazdym reroutom
      final Map tempMap = ModalRoute.of(context)!.settings.arguments as Map;
      if(tempMap['firstStart']==false){
        //final data = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
        //final Map convertedData = ModalRoute.of(context)!.settings.arguments as Map;
        dataWToken=tempMap;
        checkForNewBooks();
        //retriveString = data.data as Map;
        //token=data.token;
      }
      else{
        //Map m = ModalRoute.of(context)?.settings?.arguments as Map;
        began=tempMap['firstStart'];
        //print(b);
        booksList=tempMap['fetchedBooks'];
        dataWToken=tempMap['dataWToken'];
      }
    }

    if (!began) {
      print(began);
      checkForNewBooks();
      return WillPopScope(
          onWillPop: () async {
        // show the snackbar with some text
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The System Back Button is Deactivated')));
        return false;
      },
    child:  Scaffold(
          backgroundColor: Colors.blue[900],
          body: Center(
              child: SpinKitPouringHourglass(
            color: Colors.white,
            size: 50.0,
          ))));
    } else {
      began=false;
      return WillPopScope(
          onWillPop: () async {
        // show the snackbar with some text
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The System Back Button is Deactivated')));
        return false;
      },
    child:  Scaffold(
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
          )));
    }
  }

  checkForNewBooks(){
    WidgetsBinding.instance.addPostFrameCallback((_) async {
    if(booksList.isEmpty){
      List temp = await setUpBooks();
      Navigator.pushNamed(context, '/home',
          arguments: {
        "loadingInProgress" :false,
            "fetchedBooks":temp,
        "firstStart":true,
            "dataWToken":dataWToken
      });
    }
    else{
      Navigator.pushNamed(context, '/home',arguments: {
        "loadingInProgress" :false,
        "fetchedBooks":booksList,
        "firstStart":true,
        "dataWToken":dataWToken
      });
    }
    });
  }
}
