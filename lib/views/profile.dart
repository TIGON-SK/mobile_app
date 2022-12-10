import 'dart:async';

import 'package:flutter/material.dart';
import 'package:library_app/api/book_data.dart';
import 'package:library_app/api/get_reserved.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../api/get_books_&_users.dart';
import 'explore.dart';
import 'login.dart';

class Profile extends StatefulWidget {
  Map map = {};

  Profile(this.map);

  @override
  ProfileState createState() => ProfileState(map);
}

class ProfileState extends State<Profile> {
  Map map = {};
  final List<String> entries = ['Aaa', 'B', 'C'];

  ProfileState(this.map);

  @override
  Widget build(BuildContext context) {
    String smallSentence(String bigSentence) {
      if (bigSentence.length > 30) {
        return bigSentence.substring(0, 30) + '...';
      } else {
        return bigSentence;
      }
    }

    GetReserved gr = GetReserved(map);
    Future<List<Book>> books = gr.getUsersBooks();

    String s = map["userDataFetched"]["image"];
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: [
      Center(
          child: Text(
        "Profil",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      )),
      Padding(
          padding: EdgeInsets.only(top: 20),
          child: Center(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(1000.0),
            child: Image.network(
              s,
              height: 200.0,
              width: 200.0,
            ),
          ))),
      Padding(
          padding: EdgeInsets.only(top: 20),
          child: SingleChildScrollView(
              child: Container(
                  child: Column(
            children: [
              Text("Rezervovane knihy",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
              FutureBuilder<List<Book>>(
                  future: books,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                          child: Container(
                              child: Column(children: [
                        Text("Knihy",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 30)),
                        ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: snapshot.data?.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Card(
                                  child: SizedBox(
                                width: 300,
                                height: 120,
                                child: Column(
                                  children: [
                                    Center(
                                        child: Padding(
                                            padding:
                                                EdgeInsets.only(bottom: 20),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(5),
                                                  //apply padding to all four sides
                                                  child: Text((snapshot
                                                              .data![index]
                                                              .title
                                                              .length >
                                                          58)
                                                      ? smallSentence(snapshot
                                                          .data![index].title)
                                                      : snapshot
                                                          .data![index].title),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.all(5),
                                                  //apply padding to all four sides
                                                  child: FadeInImage(
                                                    image: NetworkImage(
                                                        "http://10.0.2.2:8000/books/${snapshot.data![index].image}"),
                                                    placeholder:
                                                        AssetImage("assets/i"
                                                            "mage"
                                                            "s/bl"
                                                            "ankb"
                                                            "ook"
                                                            ".png"),
                                                    height: 50,
                                                    imageErrorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Image.asset(
                                                          'assets'
                                                          '/i'
                                                          'ma'
                                                          'ge'
                                                          's/'
                                                          'un'
                                                          'av'
                                                          'ai'
                                                          'la'
                                                          'ble'
                                                          ''
                                                          '.png',
                                                          fit: BoxFit.fitWidth);
                                                    },
                                                    fit: BoxFit.fitWidth,
                                                  ),
                                                ),
                                              ],
                                            )))
                                  ],
                                ),
                              ));
                            })
                      ])));
                    } else {
                      return Text("loading..");
                    }
                  }),
            ],
          ))))
    ])));
  }
}
