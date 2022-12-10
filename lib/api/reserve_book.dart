import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class ReserveBook {
  int user_id;
  int book_id;
  ReserveBook(this.user_id,this.book_id);
  //List<Book> booksFetched = [];
  //Map<String, dynamic> map = {};
  Future<void> reserve(token) async {

    final response =
    await http.post(Uri.parse('http://10.0.2.2:8000/api/reserve/store_bookUser'
        '?user_id=${user_id}&book_id=${book_id}'),
        headers: {
      // "Content-type": "application/json",
      "Accept": "application/json",
      'Authorization': "Bearer "+token
    },
    );
    if (response.statusCode == 200) {
      if(json.decode(response.body)["book user"]==null){
        Fluttertoast.showToast(
            msg: "Nedostatok kníh na sklade",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    } else {
      print(response.statusCode);
      throw Exception('Failed to load books');
    }
  }


}