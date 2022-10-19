import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/book.dart';

class BookData {
  String responsex = "";

  BookData() {
  }

  Future<List<Book>> getBooks() async {
    // List<Book> listOfBooks = [];
    // List listOfBooks2 = [];
    var uri = Uri.parse('http://10.0.2.2:8000/api/books');
    final response = await http.get(uri);
    int id = 0;
    String title = "";
    // listOfBooks2 = json.decode(response.body)
    //     .map((data) => Book.fromJson(data))
    //     .toList();

    if (response.statusCode == 200) {
      // json = responsex;
      // Book obj = Book.fromJson(json['id'],json['title']);
      // responsex = response.body;
      // const start = "[";
      // const end = "]";
      //
      // final startIndex = responsex.indexOf(start);
      // final endIndex = responsex.indexOf(end, startIndex + start.length);
      //
      // print(responsex.substring(startIndex + start.length, endIndex));
      // //Map data = jsonDecode(responsex[0]);
      // print(responsex[0]);
      // List<dynamic> jsonResponse = json.decode(response.body);
      // List<Book> mReturnVal = [];
      // jsonResponse.map((element) {mReturnVal.add(new Book.fromJson(element));}).toList();
      // print(jsonResponse[0].toString());
      // //Map data = jsonDecode(jsonResponse[0]['title']);
      // Map<String, String> data = json.decode(response.body);
      // print(data.toString());

      //Map<String, dynamic> datax = data["title"];
      //Map<String, dynamic> stringQueryParameters =
     // data.map((key, value) => MapEntry(key, value.toString()));
      //print(stringQueryParameters.toString());
      //responsex = response.body;
      //Map data = jsonDecode(responsex);
      //print(responsex);
      //responsex.toString();
      // Map<String, dynamic> data = json.decode(responsex);
      // id = data['id'][0];
      // title = data['title'][0].toString();
    }

    //Book book = new Book(id, title);
    for( int i = 0 ; i >= 1; i-- ) {
      //print(i);
    }

    //listOfBooks.add(book);
    // return listOfBooks;
  }
}
