// import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';
import 'package:flutter/material.dart';
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
      body:SafeArea(child:  Padding(padding: EdgeInsets.symmetric(horizontal: 24 ),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
              child:
              //     first column
              Column(
                children: [
                  CircleAvatar(

                    radius: 70,
                    // backgroundColor: Colors.red,
                    backgroundImage:AssetImage("assets/images/sumeya_logo.jpg"),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Sumeya Hassen",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25),),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Flutter develope",style: TextStyle(),),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),


            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24,vertical: 30),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(10)
              ),
              child:
              //   second colomen,
              Column(

                children: [
                 Row(
                   children: [
                Text("Email:",style: TextStyle(fontWeight: FontWeight.w500),),
                SizedBox(
                  width: 20,
                ),
                Text("sumeyahassensumi@gmail.com",style: TextStyle(fontWeight: FontWeight.w300),)
                   ],

                 ),

                 Padding(padding: EdgeInsetsGeometry.symmetric(vertical: 5),
                 child: Divider(),),
                  Row(
                    children: [
                      Text("Location:",style: TextStyle(fontWeight: FontWeight.w500),),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Addis Abeba Ethiopia",style: TextStyle(fontWeight: FontWeight.w300),)
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24,vertical: 30),
              decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(10)
              ),
              child:
              //   third column,
              Column(

                children: [
                  Row(
                    children: [
                      Text("Role:",style: TextStyle(fontWeight: FontWeight.w500),),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Flutter Developer",style: TextStyle(fontWeight: FontWeight.w300),)
                    ],

                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Text("Location:",style: TextStyle(fontWeight: FontWeight.w500),),
                      SizedBox(
                        width: 20,
                      ),
                      Text("Addis Abeba Ethiopia",style: TextStyle(fontWeight: FontWeight.w300),)
                    ],
                  ),
                ],
              ),
            ),
            Spacer(),
            Container(
              width:double.maxFinite,
              padding: EdgeInsetsGeometry.symmetric(vertical: 24),
              child: ElevatedButton(onPressed: (){},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[300],
                    padding: EdgeInsetsGeometry.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(8))

                  ),
                  child: Text("Edite Profile",style: TextStyle(color: Colors.white),)),
            ),
            SizedBox(
              height: 20,
            )

          ],
        ),))

    );
  }
}
