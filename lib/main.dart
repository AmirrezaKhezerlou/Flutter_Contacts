import 'package:flutter/material.dart';

import 'Views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contacts',
     theme: ThemeData(
      // fontFamily: 'dana',
           accentColor: Colors.black,
     ),
      home:  Home(),
    );
  }
}

