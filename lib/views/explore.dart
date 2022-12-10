import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:library_app/api/book_data.dart';
import 'package:library_app/api/reserve_book.dart';
import 'package:library_app/views/loadingData.dart';
import 'package:library_app/views/register.dart';
import 'package:library_app/views/screenArguments.dart';
import 'package:library_app/views/widgets/navigation.dart';

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

  // Future <List> booksList = [] as Future<List>;

  // //bool loadingInProgress = true;
  // Map retriveString = {};
  Map dataWToken = {};
  bool filledParams;

  ExploreState(this.dataWToken, this.loading, this.filledParams);

  bool loading = true;

  //BooksApi instance = BooksApi();
  // final Future<List> booksExpected = Future<List>.delayed(
  //       () => BooksApi().fetchBooks(dataWToken["obtainedToken"]),
  // );

  @override
  Widget build(BuildContext context) {
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
                                    height: 120,
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
                                                      child: Text(snapshot
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
            //   if (snapshot.hasData) {
            //     //print();
            //     return ListView.builder(
            //       itemCount: snapshot.data!.length,
            //       itemBuilder: (context, index) {
            //         String s="";
            //         booksList.then((value) => s=value as String);
            //         print(s);
            //         return Text(s);
            //       },
            //     );
            //           return Card(
            //               child: Padding(
            //                 padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
            //                 child: Column(
            //                   children: [
            //                     Text("${booksList.toString()}"),
            //
            //                   ],
            //                 ),
            //               ));
            // }
            //   else{
            //     print("asdawsfefwef");
            //     return Text("Ziadne pripojenie na databazu.");
            //   }
          }),
    );
  }

  void apiRequest(int index) {
    ReserveBook reserveBook  = ReserveBook(dataWToken["userDataFetched"]["id"],
        index);
    reserveBook.reserve(dataWToken["obtainedToken"]);

  }
}
//   print(filledParams);
//     if(filledParams==true){
//       loading=false;
//       print("A");
//     }
//     else{
//       print("B");
//       checkForNewBooks();
//       loading=false;
//     }
//
//   if(loading){
//     return WillPopScope(
//         onWillPop: () async {
//           // show the snackbar with some text
//           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//               content: Text('The System Back Button is Deactivated')));
//           return false;
//         },
//         child:  Scaffold(
//             backgroundColor: Colors.blue[900],
//             body: Center(
//                 child: SpinKitPouringHourglass(
//                   color: Colors.white,
//                   size: 50.0,
//                 ))));
//   }
//   else{
//     return WillPopScope(
//         onWillPop: () async {
//           // show the snackbar with some text
//           ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//               content: Text('The System Back Button is Deactivated')));
//           return false;
//         },
//         child:  Scaffold(
//             body: Container(
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: EdgeInsets.all(50.0),
//                   child: Column(
//                     children: [
//                       Text("Knihy",
//                           style: TextStyle(
//                               fontSize: 30.0, fontWeight: FontWeight.bold)),
//                       ListView.builder(
//                           scrollDirection: Axis.vertical,
//                           shrinkWrap: true,
//                           physics: ClampingScrollPhysics(),
//                           itemCount: booksList.length,
//                           itemBuilder: (BuildContext context, int index) {
//                             return Card(
//                                 child: Padding(
//                                   padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
//                                   child: Column(
//                                     children: [
//                                       Text("${booksList[index].id}"),
//                                       Text("${booksList[index].title}"),
//                                     ],
//                                   ),
//                                 ));
//                           }),
//                     ],
//                   ),
//                 ),
//               ),
//             )));
//   }
//  }
//
// void checkForNewBooks(){
//   WidgetsBinding.instance.addPostFrameCallback((_) async {
//     List temp = await setUpBooks();
//     //PORIESIT
//     print("C");
//     Explore(dataWToken, temp, false,true);
//     // Navigator.of(context).push(MaterialPageRoute(builder: (context) => Explore(dataWToken, temp,
//     //     false,true)));
//     // Navigator.pushNamed(context, '/home',
//     //     arguments: {
//     //   "loadingInProgress" :false,
//     //       "fetchedBooks":temp,
//     //   "loading":false,
//     //       "dataWToken":dataWToken
//     // });
//   });
// }
