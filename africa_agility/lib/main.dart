import 'package:flutter/material.dart' hide Card;
// import 'package:africa_agility/card.dart';
// import 'package:africa_agility/project1.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("class one"),
          backgroundColor: Colors.blue,
          centerTitle: true,
        ),
        body:
          Padding(padding: EdgeInsetsGeometry.all(20),
            child: Column(
                children: [

                  Container(
                    height: 100,
                    width: 400,
                    decoration: BoxDecoration(
                      color: Colors.green[200],
                      borderRadius: BorderRadius.circular(10)

                    ),
                    child: Padding(padding:EdgeInsetsGeometry.fromLTRB(15, 0, 0, 0) ,
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("User summery",
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),
                          ),
                          Text("Name sumeya hassen"),
                          Text("total score 75")
                        ],
                      ),
                    ),),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 100,
                    width: 400,
                    decoration: BoxDecoration(
                      color: Colors.orange[200],
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(padding: EdgeInsetsGeometry.fromLTRB(15, 0, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Primery sckill" ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                        Text("Skill-Flutter")
                      ],
                    ),)
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 100,
                    width: 400,
                    decoration: BoxDecoration(
                      color: Colors.blue[200],
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(padding:EdgeInsetsGeometry.fromLTRB(15, 0, 0, 0) ,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("profile info", style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),
                          Text("Sumeya flutter develope"),
                          Text("Addis Abeba Ethiopia")
                        ],)
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  )
                ]
          )


      ),
      ),
    );
  }
}
