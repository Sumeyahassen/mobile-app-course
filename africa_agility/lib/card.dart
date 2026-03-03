import 'package:flutter/material.dart';
class Card extends StatelessWidget {
  const Card({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
    child: Container(
      height: 60,
     width: 200,
     decoration: BoxDecoration(
       color: Colors.green,
       borderRadius: BorderRadius.circular(20),
     ),
      child: Center(
        child: Text("Box one"),
      ),
    ),
    );
  }
}
