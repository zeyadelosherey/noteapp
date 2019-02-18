import 'package:flutter/material.dart';
import 'package:noteapp/UI/MyHomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        accentColor: Colors.black
         ),
      home: MyHomePage(title: 'NoteApp DEMO'),
    );
  }
}

