import 'package:flutter/material.dart';
class Grid extends StatelessWidget {
  const Grid ({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(child: Container(
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.blue[200],
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Center(
                    child: Text("Box 1",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                  ),

                ),),
                SizedBox(
                  width:10 ,
                ),
                Expanded(child: Container(
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green[200]
                  ),

                ),),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(child: Container(
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.orange[200],
                      borderRadius: BorderRadius.circular(20)
                  ),
                ),),
                SizedBox(
                  width:10 ,
                ),
                Expanded(child: Container(
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue[200]
                  ),
                  child: Center(
                    child: Text("Box 2",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
                  ),
                ),),
              ],

            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Expanded(child: Container(
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.blue[200],
                      borderRadius: BorderRadius.circular(20)
                  ),

                ),),
                SizedBox(
                  width:10 ,
                ),
                Expanded(child: Container(
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.green[200]
                  ),
                ),),
              ],

            ),
            SizedBox(
              height: 15,
            ),
            Expanded(child: Container(
              height: 100,
              width: 415,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.blue[200]
              ),
              child: Center(
                child: Text("Box 4",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
              ),
            ),
            ),
            SizedBox(
              height: 15,
            ),

            Row(
              children: [
                Expanded(child: Container(
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(
                      color: Colors.green[200],
                      borderRadius: BorderRadius.circular(20)
                  ),

                ),),
                SizedBox(
                  width:10 ,
                ),
                Expanded(child: Container(
                  height: 100,
                  width: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.orange[200]
                  ),
                ),),
              ],
            ),
            SizedBox(
              height: 15,
            ),

          ],
        ),
      )
    );
  }
}
