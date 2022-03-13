import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicators/linear_progress_page_indicator.dart';
import 'package:untitled2/datas/details.dart';

class IngredientsShowOff extends StatefulWidget {
  details detail;
  IngredientsShowOff(this.detail, {Key? key}) : super(key: key);

  @override
  _IngredientsShowOffState createState() => _IngredientsShowOffState();
}

class _IngredientsShowOffState extends State<IngredientsShowOff> {

  final _currentPageNotifier = ValueNotifier<int>(0);
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    print(widget.detail.ingredients![1]["image"]);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            bottom: height/2,
            right: -height/3/3,
            child: Container(
              height: height/3,
              width: height/3,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(218, 191, 255, 1),
                  borderRadius: BorderRadius.circular(height/3)
              ),
            ),
          ),
          ListView(
            children: [
              LinearProgressPageIndicator(
                itemCount: widget.detail.ingredients!.length,
                currentPageNotifier: _currentPageNotifier,
                height: 10,
                width: width,
                progressColor: Colors.pink,
                backgroundColor: Colors.white,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: const SizedBox(
                        width: 30,
                        height: 50,
                        child: Icon(Icons.clear, size: 50,)
                      ),
                    )
                  ),
                ],
              ),
              Container(
                height: height-70,
                width: width,
                child: PageView.builder(
                  controller: _pageController,
                    itemCount: widget.detail.ingredients!.length,
                    itemBuilder: (context, index){
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                widget.detail.ingredients![index]["image"] != null ? Padding(
                                  padding: const EdgeInsets.fromLTRB(8, 3, 8, 3),
                                  child: Container(
                                    child: RichText(
                                      text: TextSpan(
                                          text: "Weight:",
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.bold,
                                              fontSize: height*0.03,
                                              color: Colors.black
                                          ),
                                          children: [
                                            TextSpan(
                                                text: "  ${widget.detail.ingredients![index]["weight"].toStringAsFixed(2)} grams",
                                                style: TextStyle(
                                                    fontSize: height*0.03,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w300
                                                )
                                            )
                                          ]
                                      ),
                                    ),
                                  ),
                                ) : Container(),
                                widget.detail.ingredients![index]["image"] != null ? Padding(
                                  padding: const EdgeInsets.fromLTRB(8, 3, 8, 3),
                                  child: Container(
                                    child: RichText(
                                      text: TextSpan(
                                          text: "Category:",
                                          style: TextStyle(
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.bold,
                                              fontSize: height*0.03,
                                              color: Colors.black
                                          ),
                                          children: [
                                            TextSpan(
                                                text: "  ${widget.detail.ingredients![index]["foodCategory"]}",
                                                style: TextStyle(
                                                    fontSize: height*0.03,
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w300,
                                                ),
                                            )
                                          ]
                                      ),
                                    ),
                                  ),
                                ) : Container(),
                              ],
                            ),
                          ),
                          widget.detail.ingredients![index]["image"] != null ? Padding(
                            padding: const EdgeInsets.all(50.0),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Text(
                                widget.detail.ingredients![index]["text"],
                                style: TextStyle(
                                    fontSize: height*0.03,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ):Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0 , height/2-50),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                widget.detail.ingredients![index]["text"],
                                style: TextStyle(
                                    fontSize: height*0.03
                                ),
                              ),
                            ),
                          ),
                          widget.detail.ingredients![index]["image"] != null ? Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Container(
                              height: width,
                              width: width,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(widget.detail.ingredients![index]["image"]),
                                    fit: BoxFit.cover
                                  )
                              ),
                              child: Center(
                                child: widget.detail.ingredients![index]["image"] == null ? Text("Not Available", style: TextStyle(fontSize: 40, color: Colors.white, letterSpacing: 2, fontWeight: FontWeight.bold),) : Text(""),
                              ),
                            ),
                          ): Container(),
                          Padding(
                            padding: EdgeInsets.fromLTRB(width/4*3, 20, 20, 20),
                            child: TextButton(
                                onPressed: (){
                                  index+1 != widget.detail.ingredients!.length ?_pageController.nextPage(duration: Duration(milliseconds: 1000), curve: Curves.bounceOut): Navigator.pop(context);
                                },
                                child: Text(
                                    index+1 == widget.detail.ingredients!.length ? "Close" : "Next",
                                  style: TextStyle(
                                    color: Colors.white,
                                    letterSpacing: 2
                                  ),
                                ),
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                            ),
                          )
                        ],
                      );
                    },

                    onPageChanged: (int index) {
                      _currentPageNotifier.value = index;
                    }
                ),
              ),
            ],
          ),
          Positioned(
            bottom: -height/3/2,
            left: -height/3/2,
            child: Container(
              height: height/3,
              width: height/3,
              decoration: BoxDecoration(
                  color: Color.fromRGBO(129, 214, 227, 1),
                  borderRadius: BorderRadius.circular(height/3)
              ),
            ),
          ),
        ],
      ),
    );
  }
}
