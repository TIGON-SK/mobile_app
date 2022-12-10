import 'dart:async';

import 'package:flutter/material.dart';
import 'package:library_app/api/book_data.dart';
import 'package:library_app/api/reserve_book.dart';

class Explore extends StatefulWidget {
  Map map = {};
  bool loading;
  bool filledParams;

  Explore(this.map, this.loading, this.filledParams);

  @override
  ExploreState createState() => ExploreState(map, loading, filledParams);
}

class ExploreState extends State<Explore> {
  String token = "";

  Map dataWToken = {};
  bool filledParams;

  ExploreState(this.dataWToken, this.loading, this.filledParams);

  bool loading = true;

  @override
  Widget build(BuildContext context) {
    String smallSentence(String bigSentence){
      if(bigSentence.length > 30){
        return bigSentence.substring(0,30) + '...';
      }
      else{
        return bigSentence;
      }
    }
    Future<List<Book>> setUpBooks() async {
      BooksApi instance = BooksApi();
      await instance.fetchBooks(dataWToken["obtainedToken"]);
      return instance.booksFetched;
    }

    Future<List<Book>> booksList = setUpBooks();
    return Scaffold(
      body: FutureBuilder<List<Book>>(
          future: booksList,
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
                                    height: 140,
                                    child: Column(
                                      children: [
                                        Center(
                                            child: Padding(
                                                padding: EdgeInsets.only
                                                  (bottom: 20),
                                                child: Column(
                                                  children: [
                                                    Padding(
                                                      padding: EdgeInsets.all
                                                        (5), //apply padding to all four sides
                                                      child: Text((snapshot
                                                          .data![index].title
                                                              .length>58)
                                                          ?smallSentence(snapshot
                                                          .data![index].title
                                                      ):snapshot
                                                          .data![index].title),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.all
                                                        (5), //apply padding to all four sides
                                                      child: Text("Počet kusov na "
                                                          "sklade:${snapshot
                                                          .data![index].count_available}"),
                                                    ),
                                                    ElevatedButton(onPressed:
                                                        () {
                                                      apiRequest(int.parse
                                                        (snapshot
                                                          .data![index].id));
                                                        },
                                                      child: Text
                                                        ("Rezervovať"),)
                                                  ],
                                                )))
                                      ],
                                    ),
                                  ));
                                })
                          ])));
            } else if (snapshot.hasError) {
              return Text("No data",
                  style: TextStyle(color: Colors.red.withOpacity(0.6)));
            }
            return const CircularProgressIndicator();

          }),
    );
  }

  void apiRequest(int index) {
    ReserveBook reserveBook  = ReserveBook(dataWToken["userDataFetched"]["id"],
        index);
    reserveBook.reserve(dataWToken["obtainedToken"]);

  }
}

