import 'package:flutter/material.dart';
final passwordBorderStyle=OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red)
);
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:
      Padding(padding:const EdgeInsets.symmetric(horizontal: 12,vertical: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios,size: 20,)),
            SizedBox(
              height: 40,
            ),
            Text("Glad you're back",
                style: TextStyle(fontWeight: FontWeight.w600,fontSize: 24),
            ),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              width: 360,
              child: Column(

                children: [
                  TextField(
                    decoration: InputDecoration(
                        hintText: "Name",
                        label: Text("Full Name"),
                        suffixIcon: Icon(Icons.person_outline),
                        border: OutlineInputBorder()


                    ),

                  ),
                  SizedBox(
                    height: 12,),
                  TextField(
                    decoration:InputDecoration(
                      hintText: "********",
                      label: Text("Password"),
                      suffixIcon: Icon(Icons.remove_red_eye_rounded),
                      enabledBorder:passwordBorderStyle,
                      focusedBorder:passwordBorderStyle,
                    ),

                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                      width: 360,
                    child: ElevatedButton(onPressed: (){},
                      style: ElevatedButton.styleFrom(
                        backgroundColor:const Color(0xFF000000),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadiusGeometry.circular(10),
                          side:BorderSide(color: Color(0x11ff11ff))
                        )
                      ),

                    child: Text("Login",style: TextStyle(color: Colors.white,fontSize: 24,fontWeight: .w600),),
                    ),
                  )
                ],
              ),

            ),

        
          ],
        ),
      )
      ),
    );
  }
}
