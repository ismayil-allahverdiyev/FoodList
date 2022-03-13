import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class ThirdPage extends StatefulWidget {
  const ThirdPage({Key? key}) : super(key: key);

  @override
  _ThirdPageState createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color.fromRGBO(216, 221, 249, 1),
      body: Stack(
        children: [
          Positioned(
            top: width/5,
            right: -width/10,
            child: Container(
              height: width/2,
              width: width/2,
              decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  shape: BoxShape.circle
              ),
            ),
          ),
          Positioned(
            top: -width/8,
            left: width/20,
            child: Container(
              height: width/4.5,
              width: width/4.5,
              decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle
              ),
            ),
          ),
          Positioned(
            top: width*1.1,
            left: width/6,
            child: Container(
              height: width/3.5,
              width: width/3.5,
              decoration: BoxDecoration(
                  color: Colors.limeAccent,
                  shape: BoxShape.circle
              ),
            ),
          ),
          Positioned(
            bottom: -width*0.4,
            right: -width/10,
            child: Container(
              height: width/1.5,
              width: width/1.5,
              decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  shape: BoxShape.circle
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Welcome\nHome", textAlign: TextAlign.center,style: TextStyle(fontFamily: "Qwitcher", fontSize: 100),),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 60,
                    width: 110,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: Colors.red,
                    ),
                    child: TextButton(
                      onPressed: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => MyApp()));
                      },
                      child: Center(child: Text("Continue", style: TextStyle(color: Colors.white, fontSize: 20),)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Positioned(
          //   bottom: 40,
          //   right: 40,
          //   child: Container(
          //     height: 70,
          //     width: 110,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.all(Radius.circular(10)),
          //       color: Colors.red,
          //     ),
          //     child: TextButton(
          //         onPressed: (){
          //           Navigator.of(context).push(MaterialPageRoute(builder: (context) => Main()));
          //         },
          //         child: Center(child: Text("Continue", style: TextStyle(color: Colors.white, fontSize: 20),)),
          //       ),
          //   ),
          // )
        ],
      ),
    );
  }
}
