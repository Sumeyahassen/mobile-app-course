import 'package:flutter/material.dart';
class Card extends StatelessWidget {
  const Card({super.key});

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
