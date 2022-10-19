import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../models/book.dart';
class Books {
  Books({
    required this.books,
  });

  List<Book> books;

  factory Books.fromJson(Map<String, dynamic> json) => Books(
    books: List<Book>.from(
      json[""].map((x) => Book.fromJson(x)),
    ),
  );
}

class Book {
  final String id;
  final String title;




  const Book({
    required this.id,
    required this.title

  });

  factory Book.fromJson(Map<String, dynamic> data) {
    return Book(
      id: data['id'].toString(),
      title: data['title'].toString(),
    );
  }
}

Future<Books> fetchBooks() async {
  final response = await http
      .get(Uri.parse('http://10.0.2.2:8000/api/books'),
      headers:{
        "Content-type": "application/json",
        "Accept": "application/json",
        // 'Authorization': "Bearer "+token
      }
  );


  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // print('aaa');
    // print(json.decode(response.body));

    print(Books.fromJson(jsonDecode(response.body)));
    // List<Quiz> list = json.decode(response.body);
    // Quiz quiz = list[0];
    // json.decode(response.body).cast<Quiz>()
    return Books.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    // print('bbb');
    print(response.statusCode);
    throw Exception('Failed to load user');
  }
}

// class BookData {
//   String responsex = "";
//
//   // BookData() {
//   // }
//   // Future<String> _loadABookAsset() async {
//   //   var uri = Uri.parse('http://10.0.2.2:8000/api/books');
//   //   final response = await http.get(uri);
//   //   return response.body.toString();
//   // }
//   // Future loadBook() async {
//   //   String jsonString = await _loadABookAsset();
//   //   final jsonResponse = json.decode(jsonString);
//   //   Book book = new Book.fromJson(jsonResponse);
//   //   print(book.title);
//   // }
//   // Future<List<Book>> getBooks() async {
//   //   List<Book> listOfBooks = [];
//   //   // List listOfBooks2 = [];
//   //   var uri = Uri.parse('http://10.0.2.2:8000/api/books');
//   //   final response = await http.get(uri);
//     // int id = 0;
//     // String title = "";
//     // listOfBooks2 = json.decode(response.body)
//     //     .map((data) => Book.fromJson(data))
//     //     .toList();
//
//     // if (response.statusCode == 200) {
//       //json = responsex;
//       //Book obj = Book.fromJson(json);
//       // responsex = response.body;
//       // const start = "[";
//       // const end = "]";
//       //
//       // final startIndex = responsex.indexOf(start);
//       // final endIndex = responsex.indexOf(end, startIndex + start.length);
//       //
//       // print(responsex.substring(startIndex + start.length, endIndex));
//       // //Map data = jsonDecode(responsex[0]);
//       // print(responsex[0]);
//       // List<dynamic> jsonResponse = json.decode(response.body);
//       // List<Book> mReturnVal = [];
//       // jsonResponse.map((element) {mReturnVal.add(new Book.fromJson(element));}).toList();
//       // print(jsonResponse[0].toString());
//       // //Map data = jsonDecode(jsonResponse[0]['title']);
//       // Map<String, String> data = json.decode(response.body);
//       // print(data.toString());
//
//       //Map<String, dynamic> datax = data["title"];
//       //Map<String, dynamic> stringQueryParameters =
//      // data.map((key, value) => MapEntry(key, value.toString()));
//       //print(stringQueryParameters.toString());
//       //responsex = response.body;
//       //Map data = jsonDecode(responsex);
//       //print(responsex);
//       //responsex.toString();
//       // Map<String, dynamic> data = json.decode(responsex);
//       // id = data['id'][0];
//       // title = data['title'][0].toString();
//     // }
//
//     //Book book = new Book(id, title);
//     // for( int i = 0 ; i >= 1; i-- ) {
//     //   //print(i);
//     // }
//
//     //listOfBooks.add(book);
//     return listOfBooks;
//   }
// }
