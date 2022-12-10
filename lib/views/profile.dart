import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:library_app/api/book_data.dart';
import 'package:library_app/api/get_reserved.dart';
import 'package:library_app/api/user_token.dart';
import 'package:library_app/views/loadingData.dart';
import 'package:library_app/views/register.dart';
import 'package:library_app/views/screenArguments.dart';
import 'package:library_app/views/widgets/navigation.dart';

import '../api/get_books_&_users.dart';
import 'explore.dart';
import 'login.dart';

class Profile extends StatefulWidget {
  Map map = {};

  Profile(this.map);

  @override
  ProfileState createState() => ProfileState(map);
}

class ProfileState extends State<Profile> {
  Map map = {};
  final List<String> entries = ['Aaa', 'B', 'C'];

  ProfileState(this.map);

  @override
  Widget build(BuildContext context) {
    Future<List<BookUser>> setUpReservedBooks() async {
      BookUsersApi instance = BookUsersApi();
      await instance.fetchBookUsers(map["obtainedToken"]);
      return instance.bookUsersFetched;
    }
    GetReserved gr = GetReserved(map);
    gr.init();
    //gr.getReservedBooks();

    //Future<List<BookUser>> bookUsersList = setUpReservedBooks();
    //print(bookUsersList.toString());
    String s = map["userDataFetched"]["image"];
    return(Text("Ahoj"));
    // return Scaffold(
    //     body: Column(children: [
    //     Center(
    //     child: Text(
    //     "Profil",
    //       style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    //     )),
    // Padding(
    // padding: EdgeInsets.only(top: 20),
    // child: Center(
    // child: ClipRRect(
    // borderRadius: BorderRadius.circular(1000.0),
    // child: Image.network(
    // s,
    // height: 200.0,
    // width: 200.0,
    // ),
    // ))),
    // Padding(
    // padding: EdgeInsets.only(top: 20),
    // child: SingleChildScrollView(
    // child: Container(
    // child: Column(
    // children: [
    // Text("Rezervovane knihy",
    // style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
    // FutureBuilder<List<BookUser>>(
    // future: bookUsersList,
    // builder: (context, snapshot) {
    //   if (snapshot.hasData) {
    //     return SingleChildScrollView(
    //         child: ListView.builder(
    //     scrollDirection: Axis.vertical,
    // shrinkWrap: true,
    // physics: ClampingScrollPhysics(),
    // itemCount: snapshot.data?.length,
    // itemBuilder: (BuildContext context, int index) {
    // return Text(snapshot.data![index].user_id);})
    //     );
    //   }
    //   else{
    //     return Text("opa");
    //   }
    // }
    // ),ListView.builder(
    //
    // padding: const EdgeInsets.all(8),
    // itemCount: entries.length,
    // itemBuilder: (BuildContext context, int index) {
    // return Container(
    // height: 50,
    // child: FutureBuilder<List<BookUser>>(
    // future: bookUsersList,
    // builder: (context, snapshot) {
    // if (snapshot.hasData) {
    // return Center(child: Text(entries[index]));
    // }
    // else{
    // return Center(child: Text("Nemáte "
    // "rezervované žiadne knihy"));
    // }
    // }),
    // );
    // })
    // ],
    // ))))
    // ]));
    }
  }
