import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
class A3 extends StatelessWidget {
  const A3({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child:SingleChildScrollView(
            child: Padding(padding: EdgeInsetsGeometry.symmetric(horizontal: 16,vertical: 20),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    IconButton(onPressed:(){}, icon: Icon(Icons.arrow_back_ios,size: 30,)),
                    SizedBox(
                      height: 40,
                    ),
                    Text("Glad you're back!",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 20),),
                    SizedBox(
                      height: 40,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,


                      children: [
                        TextField(
                          decoration: InputDecoration(
                              label:Text("Email"),
                              hintText: "example@gmail.com",
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey)
                              ),

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
                            shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10)),
                            side: BorderSide(color: Colors.brown)
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
                              backgroundColor:Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10),
                                  side: BorderSide(color: Colors.yellow))
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(onPressed: (){}, icon: FaIcon(FontAwesomeIcons.google, color: Colors.grey)),
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
            ),
          ) )
    );
  }
}
