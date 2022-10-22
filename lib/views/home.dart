import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:library_app/api/book_data.dart';
import 'package:library_app/views/loadingData.dart';
import 'package:library_app/views/widgets/navigation.dart';

class Home extends StatefulWidget {
  List booksList = [];

  Home(this.booksList);

  // List<Book> booksList = [];
  // Home._(this.booksList);
  @override
  HomeState createState() => HomeState(booksList);
}

class HomeState extends State<Home> {
  List booksList = [];

  HomeState(this.booksList); //_HomeState(this.booksList); //@override


  // Future <List<Book>> getBooksFromAPI() async{
  //   BooksApi ba = BooksApi();
  //   await ba.fetchBooks();
  //   List<Book> books2 = ba.booksFetched;
  //   print(books2);
  //   //setState(() { books = books2; });
  //   return books2;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Knižnica'), actions: <Widget>[
        ]),
        body: Container(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(50.0),
              child: Column(
                children: [
                  Text("Knihy",style: TextStyle(fontSize: 30.0,fontWeight: FontWeight.bold)),
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
//print(booksList.length);
// final  Map<String, Object>rcvdData = ModalRoute.of(context)?.settings.arguments;
// print("rcvd fdata ${rcvdData['name']}");
// print("rcvd fdata ${rcvdData}");
// List<Book>? booksList = [];
// Map? data = {};
//data = (data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments) as Map?;
//booksList=map as List<Book>?;
//print(data);

// final route = ModalRoute.of(context);
// // This will NEVER fail
// if (route == null) return SizedBox.shrink();
// final routeArgs = route.settings.arguments;
// booksList=routeArgs;
// print(routeArgs.runtimeType);
// if(!booksList.isNotEmpty){
//   print("A");
//   if(context!=null){
//     final r = ModalRoute.of(context as dynamic)?.settings.arguments;
//
//     // r.
//     // if(ba.booksFetched!=null){
//     //   print(ba.booksFetched[0].title);
//     // }
//
//   }
// }
// else{
//   print("B");
//   booksList=booksList;
// }

// TODO: implement build
