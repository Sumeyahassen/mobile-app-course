import 'package:flutter/material.dart' hide Card;
import 'package:africa_agility/card.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Flutter greade"),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        body: Center(
          child: Card(),
        ),

      )
    );
  }
}
