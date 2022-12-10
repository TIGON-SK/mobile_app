import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;


class BookUser {
  final String id;
  final String user_id;
  final String book_id;

  const BookUser({
    required this.id,
    required this.user_id,
    required this.book_id,
  });

  factory BookUser.fromJson(Map<String, dynamic> json) => BookUser(
      id:json["id"].toString(),
      user_id:json["user_id"].toString(),
      book_id:json["book_id"].toString()
  );
}
class BookUsers {
  List<BookUser> bookUsers=[];

  BookUsers({required this.bookUsers});


  factory BookUsers.fromJson(Map<String, dynamic> json) => BookUsers(
    bookUsers: List<BookUser>.from(
      json["book"].map((x) => BookUser.fromJson(x)),
    ),
  );
}
class BookUsersApi {
  BookUsersApi();
  List<BookUser> bookUsersFetched = [];
  Map<String, dynamic> map = {};
  Future<void> fetchBookUsers(token) async {
    final response =
    await http.post(Uri.parse('http://10.0.2.2:8000/api/reserve/getBookUsers'),
        headers: {
      "Accept": "application/json",
      'Authorization': "Bearer "+token
    });
    BookUsers bookUsersx = BookUsers.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      bookUsersFetched=bookUsersx.bookUsers;
    } else {
      print(response.statusCode);
      throw Exception('Failed to load book users');
    }
  }

}
