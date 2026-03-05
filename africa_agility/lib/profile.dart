import 'package:flutter/material.dart';
import 'dart:io';
String mylogo="/home/sumeya/Pictures/sumeya_logo.jpg";
File profile=File(mylogo);
class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.blue,
      leading: BackButton(color: Colors.white,),
      elevation: 5,
      shadowColor:Colors.black,
      centerTitle: true,
      title: Text("Profile Info",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
    ),
      // which means to add horizontale  pading for left and write
      body: Padding(padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          SizedBox(
            width: 400,
            height: 24,
          ),
          CircleAvatar(

            radius: 50,
            // backgroundColor: Colors.red,
            backgroundImage:AssetImage("assets/images/sumeya_logo.jpg"),
          )
        ],
      ),)

    );
  }
}
