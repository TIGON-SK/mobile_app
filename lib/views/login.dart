import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:library_app/views/home.dart';
import 'package:library_app/views/register.dart';
import 'package:library_app/views/loadingData.dart';
import 'package:library_app/views/screenArguments.dart';
import 'package:library_app/views/welcome.dart';
import 'package:library_app/views/widgets/navigation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

TextEditingController emailController = new TextEditingController();
TextEditingController passwordController = new TextEditingController();

bool _validateEmail = false;
bool _validatePass = false;
Map userDataFetched = {};
bool canSwitchScreenlogin = false;
var obtainedTokenLogin;

Future<void> fetchUserTokenRegister(String email, String password) async {
  final response =
      await http.post(Uri.parse('http://10.0.2.2:8000/api/auth/login'), body: {
    "email": email,
    "password": password,
  });
  final Map loginInfoParsed = json.decode(response.body);
  if (loginInfoParsed['token'] == null) {
    canSwitchScreenlogin = false;
    showToast();
  } else {
    final userResponse = await http.get(
      Uri.parse('http://10.0.2.2:8000/api/user'),
      headers: {'Authorization': "Bearer " + loginInfoParsed['token']},
    );
    if (userResponse.statusCode == 200 || userResponse.statusCode == 201) {
      canSwitchScreenlogin = true;
      obtainedTokenLogin = loginInfoParsed['token'];
      userDataFetched = json.decode(userResponse.body);
      //var userData=UserWithToken.fromJson(parsedUserResponse);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', loginInfoParsed['token']);
    } else {
      canSwitchScreenlogin = false;
      showToast();
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

class _LoginState extends State<Login> {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   title: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       FaIcon(FontAwesomeIcons.book),
        //       SizedBox(width: 10),
        //       Text('Knižnica')
        //     ],
        //   ),
        // ),
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
                  controller: emailController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      errorText: _validateEmail ? 'Zle zadaný email' : null,
                      hintText: 'Zadajte email v tvare abc@gmail.com'),
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
                      labelText: 'Password',
                      errorText: _validatePass ? 'Prázdne pole' : null,
                      hintText: 'Zadajte heslo'),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Zabudol/la som heslo',
                  style: TextStyle(color: Colors.blue, fontSize: 15),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
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
                        emailController.text.toString(),
                        passwordController.text.toString());
                    //print('${userwtoke} as');
                    // Navigator.of(context)
                    //     .push(MaterialPageRoute(builder: (context) => Home()));
                    if (canSwitchScreenlogin) {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => Welcome(),
                            settings: RouteSettings(
                              arguments: ScreenArguments(
                                  userDataFetched, obtainedTokenLogin),
                            )),
                      );
                    }
                  },
                  child: Text('Prihlásiť sa'),
                ),
              ),
              // ),
              SizedBox(
                height: 130,
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => Register()));
                },
                child: Text(
                  'Ešte nemáte účet? Vytvorte si ho',
                ),
              ),
            ],
          ),
        ),
        );
  }
}
