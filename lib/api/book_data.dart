import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../models/book.dart';

class Book {
  final String id;
  final String title;

  const Book({
    required this.id,
    required this.title,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    id: json["id"].toString(),
    title: json["title"],
  );
}

class BooksApi {
  BooksApi();
  List<Book> booksFetched = [];
  Map<String, dynamic> map = {};
  Future<void> fetchBooks() async {
    final response =
    await http.get(Uri.parse('http://10.0.2.2:8000/api/books'), headers: {
      "Content-type": "application/json",
      "Accept": "application/json",
      // 'Authorization': "Bearer "+token
    });
    List<dynamic> parsedListJson = jsonDecode(response.body);
    List<Book> bookList = List<Book>.from(
        parsedListJson.map<Book>((dynamic i) => Book.fromJson(i)));
    if (response.statusCode == 200) {
      booksFetched=bookList;
    } else {
      print(response.statusCode);
      throw Exception('Failed to load books');
    }
  }

}
