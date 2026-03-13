import 'package:flutter/material.dart';
class A3 extends StatelessWidget {
  const A3({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child:Padding(padding: EdgeInsetsGeometry.symmetric(horizontal: 16,vertical: 20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                 IconButton(onPressed:(){}, icon: Icon(Icons.arrow_back_ios,size: 40,)),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Glad you're back!",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16),),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,


                    children: [
                      TextField(
                       decoration: InputDecoration(
                         label:Text("Email"),
                         hintText: "example@gmail.com",
                        border: OutlineInputBorder()
                       ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            label:Text("Password"),
                            hintText: "********",
                            suffixIcon: Icon(Icons.remove_red_eye_rounded),
                            border: OutlineInputBorder()
                        ),
                      ),
                    ],
                  ),
                      SizedBox(
                        height: 10,
                      ),
                     Row(
                       // mainAxisAlignment: MainAxisAlignment.end,
                       // crossAxisAlignment:CrossAxisAlignment.end ,
                       children: [
                         SizedBox(
                           width: 200,
                         ),
                         Text("Forgot Password?")
                       ],
                     ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 340,
                    height: 50,
                    child: ElevatedButton(onPressed: (){},
                      style: ElevatedButton.styleFrom(
                          backgroundColor:Colors.black,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10))
                      ),
                      child: Text("Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),)
                    ,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 5,

                      ),
                      Expanded(child: Divider(
                        thickness: 1,color: Colors.grey,
                      ),),
                      Text(" Or"),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(child: Divider(
                        thickness: 1,color: Colors.grey,
                      ))

                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 340,
                    height: 50,
                    child: ElevatedButton(onPressed: (){},
                      style: ElevatedButton.styleFrom(
                          backgroundColor:Colors.white60,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10))
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(onPressed: (){}, icon: Icon(Icons.golf_course_outlined)),
                          Text("Login with google",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),
                          ),
                        ],
                      )
                    )
                    ,
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don't have an account",style: TextStyle(fontWeight: FontWeight.w400),),
                      Text(" SignUp",style: TextStyle(fontWeight: FontWeight.w800,fontSize: 14),),
                    ],
                  )
                ],
              )
          ), )
    );
  }
}
