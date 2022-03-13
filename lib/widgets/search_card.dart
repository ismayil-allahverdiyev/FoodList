
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled2/datas/details.dart';
import 'package:untitled2/loading/loading.dart';
import 'package:untitled2/screens/receipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SearchCard extends StatefulWidget {
  details? detail;
  String image = "https://www.edamam.com/web-img/7a2/7a2f41a7891e8a8f8a087a96930c6463.jpg";
  String label = "name of the meal";
  Color? color;
  List<details>? favreceipes;

  SearchCard(details? detail, String? image, String? label, Color? color, {Key? key}) : super(key: key){
    this.detail = detail!;
    this.image = image!;
    this.label = label!;
    this.color = color!;
  }
  @override
  State<SearchCard> createState() => _SearchCardState();
}

class _SearchCardState extends State<SearchCard> {
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
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: width/3,
                    width: width/3,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        image: DecorationImage(
                          image: NetworkImage(widget.image),
                        )
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.label.length>25?Padding(
                        padding: const EdgeInsets.fromLTRB(5,3,5,3),
                        child: Text("${widget.label.substring(0,25)}...", style: TextStyle(fontSize: width*2/45, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),),
                      ):Padding(
                        padding: const EdgeInsets.fromLTRB(5,3,5,3),
                        child: Text("${widget.label}", style: TextStyle(fontSize: width/3*2/15, fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5,3,5,3),
                        child: Row(
                          children: [
                            Icon(Icons.timer, size: width*2/45),
                            Text("  ${widget.detail!.totalTime} minutes", style: TextStyle(fontSize: width*2/45, letterSpacing: 2, fontWeight: FontWeight.w300))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5,3,5,3),
                        child: Row(
                          children: [
                            Icon(Icons.add_task_rounded, size: width*2/45,),
                            Text("  ${widget.detail!.calories} kCal", style: TextStyle(fontSize: width*2/45, letterSpacing: 2, fontWeight: FontWeight.w300))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(5,3,5,3),
                        child: Row(
                          children: [
                            Icon(Icons.accessibility, size: width*2/45),
                            Text("  ${widget.detail!.totalTime} gr protein", style: TextStyle(fontSize: width*2/45, letterSpacing: 2, fontWeight: FontWeight.w300))
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
                // Container(
                //   height: 150,
                //   width:150,
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.all(Radius.circular(20)),
                //     image: DecorationImage(
                //       image: NetworkImage(widget.image),
                //     )
                //   ),
                // ),
                // Text(widget.label),
                // Column(
                //   children: [
                //     Text(widget.label),
                //     Row(
                //       children: [
                //         Icon(Icons.timer),
                //         Text("${widget.detail!.totalTime} minutes")
                //       ],
                //     ),
                //     Row(
                //       children: [
                //         Icon(Icons.add_task_rounded),
                //         Text("${widget.detail!.calories} kCal")
                //       ],
                //     ),
                //     Row(
                //       children: [
                //         Icon(Icons.accessibility),
                //         Text("${widget.detail!.totalTime} gr protein")
                //       ],
                //     ),
                //   ],
                // ),
              ),
            ),
          )
        )
    );
  }
}
