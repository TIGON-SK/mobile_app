import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:library_app/api/book_data.dart';

import 'book_data.dart';
import 'get_books_&_users.dart';

class GetReserved {
  Map map = {};

  GetReserved(this.map);

  List<Book> lb = [];
  List<BookUser> lbu = [];
Future<void> init() async {
  await getAllBooks();
  await getAllBookUsers();
  getUsersBooks();
}
  Future<List<Book>> getAllBooks() async {
    BooksApi instance = BooksApi();
    await instance.fetchBooks(map["obtainedToken"]);
    lb = instance.booksFetched;
    return instance.booksFetched;
  }

  Future<List<BookUser>> getAllBookUsers() async {
    BookUsersApi instance = BookUsersApi();
    await instance.fetchBookUsers(map["obtainedToken"]);
    lbu = instance.bookUsersFetched;
    return instance.bookUsersFetched;
  }

  void getUsersBooks() {
  print("Ahoj svet ${map["userDataFetched"]["id"]}");
    for (var i = 0; i < lbu.length; i++) {
      print(lbu[i].user_id);
      if(lbu[i].user_id==map["userDataFetched"]["id"]){
        print("Mas tieto knihy:");
        print(lbu[i].book_id);
      }
      else{
        print("Ziadne rezervovane knihy!");
      }
    }
    // print(lbu[0].user_id);
    // print("XXXXXX");
    // print(lb.toString());
  }
}
