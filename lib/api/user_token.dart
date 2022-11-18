import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
class UserWithToken {
  final int id;
  final String email;
  final String name;
  final String token;

  const UserWithToken({
    required this.id,
    required this.email,
    required this.name,
    required this.token,
  });

  factory UserWithToken.fromJson(Map<dynamic, dynamic> json) {
    return UserWithToken(
      id: json['id'] as int,
      email: json['email'].toString(),
      name: json['name'].toString(),
      token:json["token"] as String,
    );
  }
}
Future<UserWithToken> fetchUserToken(String email,String password) async {

  final response = await http
      .post(Uri.parse('http://10.0.2.2:8000/api/user'),
      headers:{
        // "Content-type": "application/json",
        // "Accept": "application/json",
        // 'Authorization': "Bearer "+token
      },
      body:{
        "email":email,
        "password":password,
      }
  );

  if (response.statusCode == 200 || response.statusCode == 201) {
    //dava mi 201 v laraveli ked to je dobre
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();

// set value
    prefs.setString('token',UserWithToken.fromJson(jsonDecode(response.body)).token );
    return UserWithToken.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    print(response.statusCode);
    print('fail in user_token');
    throw Exception('Failed to load album');
  }
}