import 'package:flutter/material.dart';
class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.blue,
      leading: BackButton(color: Colors.white,),
      title: Text("Profile Info",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
    ),
      body: Container(

      )

    );
  }
}
