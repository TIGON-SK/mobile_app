import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:library_app/views/home.dart';
import 'package:library_app/views/loadingData.dart';
import 'package:library_app/views/screenArguments.dart';
import 'package:library_app/views/welcome.dart';
import 'package:library_app/views/widgets/navigation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../api/user_token.dart';
import 'login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

TextEditingController nameController = new TextEditingController();
TextEditingController emailController = new TextEditingController();
TextEditingController passwordController = new TextEditingController();

bool _validateName = false;
bool _validateEmail = false;
bool _validateEmailUnique = false;
bool _validatePass = false;
Map userDataFetched = {};
bool canSwitchScreen = false;
var obtainedToken;

Future<void> fetchUserTokenRegister(
    String name, String email, String password) async {
  final response = await http
      .post(Uri.parse('http://10.0.2.2:8000/api/auth/register'), body: {
    "name": name,
    "email": email,
    "password": password,
  });
  final Map registerInfoParsed = json.decode(response.body);
  if(registerInfoParsed['token']==null){
    canSwitchScreen = false;
    showToast();
  }
  else{
  final userResponse = await http.get(
    Uri.parse('http://10.0.2.2:8000/api/user'),
    headers: {
      'Authorization': "Bearer " + registerInfoParsed['token'].toString()
    },
  );
  if (userResponse.statusCode == 200 || userResponse.statusCode == 201) {
    canSwitchScreen = true;
    obtainedToken=registerInfoParsed['token'];
    userDataFetched = json.decode(userResponse.body);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('token', registerInfoParsed['token']);
  } else {
    canSwitchScreen = false;
    showToast();
    // throw Exception('Failed to load data');
  }
  }
}

Future<bool?> showToast() {
  return Fluttertoast.showToast(
      msg: 'Zadajte email, ktorý ešte nie je registrovaný',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.yellow);
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(FontAwesomeIcons.book),
            SizedBox(width: 10),
            Text('Knižnica')
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Prihlasovacie meno',
                    errorText: _validateName ? 'Prázdne pole' : null,
                    hintText: 'Zadajte prihlasovacie meno'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    errorText: (_validateEmail || _validateEmailUnique
                        ? 'Zle zadaný mail'
                        : null),
                    hintText: 'Zadajte jedinečný email'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Heslo',
                    errorText:
                        _validatePass ? 'Slabé alebo žiadne heslo' : null,
                    hintText: 'Zadajte heslo'),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 0, right: 0, top: 15, bottom: 0),
              height: 50,
              width: 250,
              child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    nameController.text.isEmpty
                        ? _validateName = true
                        : _validateName = false;
                    if (emailController.text.isEmpty ||
                        !emailController.text.contains("@") ||
                        !emailController.text.contains(".")) {
                      _validateEmail = true;
                    } else {
                      _validateEmail = false;
                    }
                    passwordController.text.isEmpty ||
                            passwordController.text.length < 7
                        ? _validatePass = true
                        : _validatePass = false;
                  });
                  await fetchUserTokenRegister(
                      nameController.text.toString(),
                      emailController.text.toString(),
                      passwordController.text.toString());
                  //print('${userwtoke} as');
                  // Navigator.of(context)
                  //     .push(MaterialPageRoute(builder: (context) => Home()));
                  if (canSwitchScreen) {
                    await Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => Welcome(),
                          settings: RouteSettings(
                            arguments: ScreenArguments(userDataFetched,obtainedToken)
                          )),
                    );
                  }
                },
                child: Text('Vytvoriť konto'),
              ),
            ),
            // ),
            SizedBox(
              height: 130,
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => Login()));
              },
              child: Text(
                'Máte už účet? Prihláste sa',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
