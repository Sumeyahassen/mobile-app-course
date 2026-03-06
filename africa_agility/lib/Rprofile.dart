import 'package:flutter/material.dart';
class Rprofile extends StatelessWidget {
  const Rprofile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: BackButton(color: Colors.white,),
        title: Text("Profile screen"),
        elevation: 3,
        shadowColor: Colors.black12,
      ),
      body: SafeArea(child:
          Padding(padding: EdgeInsetsGeometry.symmetric(horizontal: 24),
     child:  Column(
       children: [
         Container(
           padding: EdgeInsetsGeometry.symmetric(horizontal: 24,vertical: 40),
           child: Column(
             children: [
               CircleAvatar(

                 backgroundImage: AssetImage("assets/images/sumeya.png"),
                 backgroundColor: Colors.tealAccent,
                 radius: 60,
               ),
               SizedBox(
                 height: 15,
               ),
               Text("Sumeya Hassen"),
               SizedBox(
                 height: 10,
               ),
               Text("Flutter Developer"),
               SizedBox(
                 height: 30,
               )
             ],

           ),
         ),
         Container(
           padding: EdgeInsetsGeometry.symmetric(horizontal: 20,vertical: 30),
           decoration: BoxDecoration(
               color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(10)
           ),
           child: Column(
             children: [
               Row(

                 children: [
                   SizedBox(
                     height: 15,
                   ),

                   Text("Email:"),
                   SizedBox(height: 20,),

                   Text("sumeyahassenmohamed@gmail.com"),
                 ],
               ),
               Padding(padding: EdgeInsetsGeometry.symmetric(vertical: 5),
                 child: Divider(),),
               Row(children: [
                 Text("Role:"),
                 SizedBox(height: 10,),
                 Text("Flutter Developer"),
                 SizedBox(
                   height: 15,
                 )
               ],),
             ],
           ),
         ),
         Container(),
         // ElevatedButton(onPressed: (){},
         //     // child: child)
       ],
     ),),
    ),
    );
  }
}
