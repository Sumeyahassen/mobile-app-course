import 'package:flutter/material.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        d
        child: Padding(padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
        child: TextField(
          decoration: InputDecoration(
            label:Text("Name") ,
            prefixIcon: Icon(Icons.insert_emoticon_outlined),
            border: OutlineInputBorder(),
            hintText: "Full Name",

          ),

        ),),
      ),
    );
  }
}
