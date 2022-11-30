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
      json["book"].map((x) => Book.fromJson(x)),
    ),
  );
}
class Book {
  final String id;
  final String title;
  final int count_available;

  const Book({
    required this.id,
    required this.title,
    required this.count_available,
  });

  factory Book.fromJson(Map<String, dynamic> json) => Book(
    id: json["id"].toString(),
    title: json["title"],
      count_available:json["count_available"]
  );
}

class BooksApi {
  BooksApi();
  List<Book> booksFetched = [];
  Map<String, dynamic> map = {};
  Future<void> fetchBooks(token) async {
    final response =
    await http.get(Uri.parse('http://10.0.2.2:8000/api/books'), headers: {
      // "Content-type": "application/json",
      // "Accept": "application/json",
      'Authorization': "Bearer "+token
    });
    //tutu je chyba!
    Books boox = Books.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      booksFetched=boox.books;
    } else {
      print(response.statusCode);
      throw Exception('Failed to load books');
    }
  }

}
