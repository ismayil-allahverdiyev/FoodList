import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:untitled2/datas/database_helper.dart';
import 'package:untitled2/providers/page_controller.dart';
import 'package:untitled2/providers/value_changer.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {

  int question1 = -1;
  int question2 = -1;

  int turn = 1;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return MediaQuery(
      data: MediaQueryData(),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(216, 221, 249, 1),
        body: Stack(
          children: [
            Positioned(
              top: -height/4,
              left: -width/4*3,
              child: Container(
                height: width,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width/2),
                  color: Color.fromRGBO(119, 118, 188, 1),
                ),
              ),
            ),
            Positioned(
              top: height/5,
              left: width/7,
              child: Container(
                height: width/6,
                width: width/6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width/6),
                  color: Colors.red,
                ),
              ),
            ),
            Positioned(
              top: height/12,
              left: width/2.5,
              child: Container(
                height: width/12,
                width: width/12,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(width/6),
                  color: Color.fromRGBO(20, 220, 220, 1),
                ),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: width-50,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(child: Text("Let me get to know you!", style: GoogleFonts.acme(fontSize: 35, letterSpacing: 1),)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: turn == 1 ? Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border.all(color: Colors.grey,width: 1, style: BorderStyle.solid)
                      ),
                      height: width-50,
                      width: width-50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: width-250,
                            child: FittedBox(child: Text("Choose your answer:", style: GoogleFonts.actor(fontSize: 35, letterSpacing: 1,fontWeight: FontWeight.bold),)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: 50,
                                width: width-100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    color: Colors.grey[100],
                                    border: Border.all(color: Colors.grey,width: 1, style: BorderStyle.solid)
                                ),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Consumer<ValueChanger>(
                                      builder: (context, valueChanger, child) => ListTile(
                                          leading: Radio(
                                            value: 1,
                                            groupValue: valueChanger.value,
                                            onChanged: (value) {
                                              setState(() {
                                                question1 = value as int;
                                                valueChanger.updateWithTheValue(value);
                                              });
                                            },
                                            activeColor: Colors.blue,
                                          ),
                                          title: Text(
                                            "Vegetables",
                                            style: GoogleFonts.actor(
                                                fontSize: 20,
                                                letterSpacing: 1,
                                                fontWeight: FontWeight.w600
                                            ),
                                          )
                                      ),
                                    )
                                )
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: 50,
                                width: width-100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    color: Colors.grey[100],
                                    border: Border.all(color: Colors.grey,width: 1, style: BorderStyle.solid)
                                ),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Consumer<ValueChanger>(
                                      builder: (context, valueChanger, child) => ListTile(
                                          leading: Radio(
                                            value: 2,
                                            groupValue: valueChanger.value,
                                            onChanged: (value) {
                                              setState(() {
                                                question1 = value as int;
                                                valueChanger.updateWithTheValue(value);
                                              });
                                            },
                                            activeColor: Colors.blue,
                                          ),
                                          title: Text(
                                            "Meat",
                                            style: GoogleFonts.actor(
                                                fontSize: 20,
                                                letterSpacing: 1,
                                                fontWeight: FontWeight.w600
                                            ),
                                          )
                                      ),
                                    )
                                )
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: 50,
                                width: width-100,
                                decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    border: Border.all(color: Colors.grey,width: 1, style: BorderStyle.solid),
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Consumer<ValueChanger>(
                                      builder: (context, valueChanger, child) => ListTile(
                                          leading: Radio(
                                            value: 3,
                                            groupValue: valueChanger.value,
                                            onChanged: (value) {
                                              setState(() {
                                                question1 = value as int;
                                                valueChanger.updateWithTheValue(value);
                                              });
                                            },
                                            activeColor: Colors.blue,
                                          ),
                                          title: Text(
                                            "Both",
                                            style: GoogleFonts.actor(
                                                fontSize: 20,
                                                letterSpacing: 1,
                                                fontWeight: FontWeight.w600
                                            ),
                                          )
                                      ),
                                    )
                                )
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: 50,
                                width: width-100,
                                decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    border: Border.all(color: Colors.grey,width: 1, style: BorderStyle.solid),
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Consumer<ValueChanger>(
                                      builder: (context, valueChanger, child) => ListTile(
                                          leading: Radio(
                                            value: 4,
                                            groupValue: valueChanger.value,
                                            onChanged: (value) {
                                              setState(() {
                                                question1 = value as int;
                                                valueChanger.updateWithTheValue(value);
                                              });
                                            },
                                            activeColor: Colors.blue,
                                          ),
                                          title: Text(
                                            "None",
                                            style: GoogleFonts.actor(
                                                fontSize: 20,
                                                letterSpacing: 1,
                                                fontWeight: FontWeight.w600
                                            ),
                                          )
                                      ),
                                    )
                                )
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: Icon(Icons.arrow_forward_ios),
                              onPressed: (){
                                setState(() {
                                  turn = 2;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ) : Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border.all(color: Colors.grey,width: 1, style: BorderStyle.solid)
                      ),
                      height: width-50,
                      width: width-50,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width-250,
                            child: FittedBox(child: Text("Choose your answer:", style: GoogleFonts.actor(fontSize: 35, letterSpacing: 1,fontWeight: FontWeight.bold),)),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: 50,
                                width: width-100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    color: Colors.grey[100],
                                    border: Border.all(color: Colors.grey,width: 1, style: BorderStyle.solid)
                                ),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Consumer<ValueChanger>(
                                      builder: (context, valueChanger, child) => ListTile(
                                          leading: Radio(
                                            value: 1,
                                            groupValue: valueChanger.value2,
                                            onChanged: (value) {
                                              setState(() {
                                                question1 = value as int;
                                                valueChanger.updateWithTheValue2(value);
                                              });
                                            },
                                            activeColor: Colors.blue,
                                          ),
                                          title: Text(
                                            "Cake",
                                            style: GoogleFonts.actor(
                                                fontSize: 20,
                                                letterSpacing: 1,
                                                fontWeight: FontWeight.w600
                                            ),
                                          )
                                      ),
                                    )
                                )
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: 50,
                                width: width-100,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    color: Colors.grey[100],
                                    border: Border.all(color: Colors.grey,width: 1, style: BorderStyle.solid)
                                ),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Consumer<ValueChanger>(
                                      builder: (context, valueChanger, child) => ListTile(
                                          leading: Radio(
                                            value: 2,
                                            groupValue: valueChanger.value2,
                                            onChanged: (value) {
                                              setState(() {
                                                question1 = value as int;
                                                valueChanger.updateWithTheValue2(value);
                                              });
                                            },
                                            activeColor: Colors.blue,
                                          ),
                                          title: Text(
                                            "Candy",
                                            style: GoogleFonts.actor(
                                                fontSize: 20,
                                                letterSpacing: 1,
                                                fontWeight: FontWeight.w600
                                            ),
                                          )
                                      ),
                                    )
                                )
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: 50,
                                width: width-100,
                                decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    border: Border.all(color: Colors.grey,width: 1, style: BorderStyle.solid),
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Consumer<ValueChanger>(
                                      builder: (context, valueChanger, child) => ListTile(
                                          leading: Radio(
                                            value: 3,
                                            groupValue: valueChanger.value2,
                                            onChanged: (value) {
                                              setState(() {
                                                question2 = value as int;
                                                valueChanger.updateWithTheValue2(value);
                                              });
                                            },
                                            activeColor: Colors.blue,
                                          ),
                                          title: Text(
                                            "Does not matter",
                                            style: GoogleFonts.actor(
                                                fontSize: 20,
                                                letterSpacing: 1,
                                                fontWeight: FontWeight.w600
                                            ),
                                          )
                                      ),
                                    )
                                )
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: 50,
                                width: width-100,
                                decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    border: Border.all(color: Colors.grey,width: 1, style: BorderStyle.solid),
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Consumer<ValueChanger>(
                                      builder: (context, valueChanger, child) => ListTile(
                                          leading: Radio(
                                            value: 4,
                                            groupValue: valueChanger.value2,
                                            onChanged: (value) {
                                              setState(() {
                                                question2 = value as int;
                                                valueChanger.updateWithTheValue2(value);
                                              });
                                            },
                                            activeColor: Colors.blue,
                                          ),
                                          title: Text(
                                            "I don't like sweet",
                                            style: GoogleFonts.actor(
                                                fontSize: 20,
                                                letterSpacing: 1,
                                                fontWeight: FontWeight.w600
                                            ),
                                          )
                                      ),
                                    )
                                )
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                              icon: Icon(Icons.arrow_back_ios_sharp),
                              onPressed: (){
                                setState(() {
                                  turn = 1;
                                });
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 40,
              right: 40,
              child: Container(
                height: 50,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.blue,
                ),
                child: Consumer<ValueChanger>(
                  builder: (context, valueChanger, _) => Consumer<PageControl>(
                    builder: (_, pageController, child) => TextButton(
                      onPressed: () async{
                        pageController.changePage();
                        int x = await DatabaseHelper.instance.insert({
                          DatabaseHelper.columnName: valueChanger.value
                        });
                        int y = await DatabaseHelper.instance.insert({
                          DatabaseHelper.columnName: valueChanger.value2
                        });

                        print("$x $y");
                      },
                      child: Text("Next", style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
