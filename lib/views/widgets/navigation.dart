import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  @override
  State<Navigation> createState() => NavigationState();
}

class NavigationState extends State<Navigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Knižnica'),
          actions: <Widget>[
      IconButton(
      icon: const Icon(Icons.add_alert),
      tooltip: 'Show Snackbar',
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('This is a snackbar')));
      },
    ),
    ]
    ),
    );
  }
}
