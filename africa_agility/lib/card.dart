import 'package:flutter/material.dart';
class Card extends StatelessWidget {
  const Card({super.key});
  // Scaffold(
  // body: Center(
  // child: Padding(padding: EdgeInsetsGeometry.symmetric(horizontal: 12),
  // child: TextField(
  // decoration: InputDecoration(
  // label:Text("Name") ,
  // prefixIcon: Icon(Icons.insert_emoticon_outlined),
  // border: OutlineInputBorder(),
  // hintText: "Full Name",
  //
  // ),
  //
  // ),),
  // ),
  // );
  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          // contener one
          Container(
            height: 100,
            width: 350,
            decoration: BoxDecoration(color: Colors.green,borderRadius: BorderRadius.circular(20)),

          ),
          SizedBox(height: 15,),
          // contener two
          Container(
            height: 100,
            width: 350,
            decoration: BoxDecoration(color: Colors.orange,borderRadius: BorderRadius.circular(20)),
          ),
          SizedBox(height: 15,),
          // contener three
          Container(
            height: 100,
            width: 350,
            decoration: BoxDecoration(color: Colors.blue,borderRadius: BorderRadius.circular(20)),
          ),
        ],
      ),
    );
  }
}
