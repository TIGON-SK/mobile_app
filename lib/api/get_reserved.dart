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
  void init() async {

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

  Future<List<Book>> getUsersBooks() async {
    await getAllBooks();
    await getAllBookUsers();
  List<int> ids = [];
    for (var i = 0; i < lbu.length; i++) {

      if(lbu[i].user_id.toString()==map["userDataFetched"]["id"].toString()){
        ids.add(int.parse(lbu[i].book_id));
      }
      else{
        print("Ziadne rezervovane knihy!");
      }
    }
  List<Book> books = [];
  for (var i = 0; i < lb.length; i++) {
    for (var j = 0; j < ids.length; j++) {
      if (lb[i].id.toString()==ids[j].toString()) {
        books.add(lb[i]);
      }
    }
  }
  return books;

  }
}
