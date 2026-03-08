import 'package:flutter/material.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:
      Padding(padding:const EdgeInsetsGeometry.symmetric(horizontal: 12,vertical: 22),
        child: Column(
          children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios,size: 20,)),
            SizedBox(
              height: 40,
            ),
            Text("Glad you're back",
                // style: TextStyle(fontWeight: FontWeight.w600,fontSize: 24),
            )
          ],
        ),
      )
      ),
    );
  }
}
