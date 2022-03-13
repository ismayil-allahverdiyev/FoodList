
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled2/datas/details.dart';
import 'package:untitled2/loading/loading.dart';
import 'package:untitled2/screens/receipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class card extends StatefulWidget {
  details? detail;
  String image = "https://www.edamam.com/web-img/7a2/7a2f41a7891e8a8f8a087a96930c6463.jpg";
  String label = "name of the meal";
  Color? color;
  List<details>? favreceipes;

  card(details? detail, String? image, String? label, Color? color, {Key? key}) : super(key: key){
    this.detail = detail!;
    this.image = image!;
    this.label = label!;
    this.color = color!;
  }
  @override
  State<card> createState() => _cardState();
}

class _cardState extends State<card> {
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
        onTap: () {
          Navigator.push(
              (context),
              MaterialPageRoute(
              builder: (context) => Receipe(widget.detail!)
          )
          );
        },
        child: MediaQuery(
          data: const MediaQueryData(),
          child: Align(
            child: SizedBox(
              width: width*0.8,
              height: width*0.6,
              child: Card(
                shadowColor:  const Color.fromRGBO(255, 150, 216, 1),
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 15,
                margin:  EdgeInsets.all(width*0.025),
                shape: RoundedRectangleBorder(
                  // side: const BorderSide(color: Colors.grey, width: 5, style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(width*0.04),
                ),
                child: Container(
                  color: widget.color,
                  child: Column(
                    children: [
                      Container(
                        height: width*0.55,
                        decoration: BoxDecoration(
                          color: Colors.black,
                              image: DecorationImage(
                                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.65), BlendMode.dstATop),
                                image: NetworkImage(widget.detail!.image!),
                              fit: BoxFit.cover,
                            )
                        ),
                        child: Center(
                            child: Text(
                              widget.label,
                              textAlign: TextAlign.center,
                              maxLines: 3,
                              style: TextStyle(
                                fontFamily: "Shizuru",
                                  fontSize: width*0.092,
                                  letterSpacing: 2,
                                  fontWeight: FontWeight.bold,
                                  color:  const Color.fromRGBO(227, 208, 216, 1),
                                  // color: Colors.greenAccent[100],
                              ),
                            )
                        ),
                    ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        )
    );
  }
}
