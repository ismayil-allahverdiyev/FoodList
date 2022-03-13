import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../loading/loading_for_search.dart';

class Selective extends StatefulWidget {
  String type = "";

  Selective(this.type, {Key? key}) : super(key: key);

  @override
  _SelectiveState createState() => _SelectiveState();
}

class _SelectiveState extends State<Selective> {

  List<String> theListOfNames = [];

  List<String> theListOfLinks = [];

  final List<String> _listItemNamesOfVegetables = [
    'peppers',
    'broccoli',
    'cabbage',
    'carrot',
    'lettuce',
    'tomato',
    'potato',
    'cucumber',
  ];

  final List<String> _listOfVegetables = [
    'https://images.unsplash.com/photo-1615375557967-227168b41ae2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fHBlcHBlcnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1620512486713-67d3cd4c8621?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDl8fGJyb2Njb2xpfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1595243065949-78da7849f1a2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NTB8fGNhYmJhZ2V8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1589927986089-35812388d1f4?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8M3x8Y2Fycm90fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1612231653032-8a93d1de0834?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDJ8fGxldHR1Y2V8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1592924357228-91a4daadcfea?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTB8fHRvbWF0b3xlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1552661397-4233881ea8c8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8cG90YXRvfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
    'https://images.unsplash.com/photo-1599448191905-7bedab8ced59?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjR8fGN1Y3VtYmVyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60',
  ];

  final List<String> _listItemNamesOfSeafood = [
    'sushi',
    'squid',
    'shrimp',
    'crab',
    'tuna',
    'oyster',
  ];

  final List<String> _listOfSeafood = [
    "https://images.unsplash.com/photo-1607301405390-d831c242f59b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjN8fHN1c2hpfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1594038751037-dfb64bfe1ea5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTV8fHNxdWlkfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1559737558-2f5a35f4523b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8c2hyaW1wfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1553659971-f01207815844?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y3JhYnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1604909052743-94e838986d24?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8Y2FubmVkJTIwdHVuYXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1627898292764-6733087b55ac?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8b3lzdGVyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
  ];


  final List<String> _listItemNamesOfMeat = [
    'sausage',
    'meatball',
    'barbeque',
    'chicken',
    'nugget',
    'bacon',
    'beef',
    'burger',
  ];

  final List<String> _listOfMeat = [
    "https://images.unsplash.com/photo-1585325701165-351af916e581?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8c2F1c2FnZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1529042410759-befb1204b468?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bWVhdGJhbGx8ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1628497622763-36456bb4d56b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NDR8fGJhcmJlY3VlJTIwbWVhdHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1501200291289-c5a76c232e5f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8Y2hpY2tlbnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1585325701956-60dd9c8553bc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8bnVnZ2V0fGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1608475861994-cf7af0f0c1be?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MTF8fGJhY29ufGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1588347785102-2944ba63d0c3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8NXx8YmVlZnxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1568901346375-23c9450c58cd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8YnVyZ2VyfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"
  ];

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Color color = const Color.fromRGBO(119, 118, 188, 1);
    String headerName = "Header";
    double padding = 60;
    String image = "";
    String searchKey = "";
    if (widget.type == "Vegetarian") {
      color = const Color.fromRGBO(154, 184, 122, 1);
      headerName = "Vegan recipes";
      image = "https://images.unsplash.com/photo-1541921671-016ccc70f7cc?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1162&q=80";
      searchKey = "&health=vegetarian";
      theListOfLinks = _listOfVegetables;
      theListOfNames = _listItemNamesOfVegetables;
    }
    if (widget.type == "Meat") {
      color = const Color.fromRGBO(239, 35, 60, 1);
      headerName = "Non-Vegan recipes";
      padding = 30;
      image = "https://images.unsplash.com/photo-1629276642577-1512117775ac?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80";
      searchKey = "";
      theListOfLinks = _listOfMeat;
      theListOfNames = _listItemNamesOfMeat;
    }
    if (widget.type == "Seafood") {
      color = const Color.fromRGBO(146, 220, 229, 1);
      headerName = "Seafood recipes";
      image = "https://images.unsplash.com/photo-1590759668642-c596ae357a42?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80";
      searchKey = "";
      theListOfLinks = _listOfSeafood;
      theListOfNames = _listItemNamesOfSeafood;
    }
    if (widget.type == "Desserts") {
      color = const Color.fromRGBO(243, 193, 120, 1);
      headerName = "Dessert recipes";
      image = "https://images.unsplash.com/photo-1541781408260-3c61143b63d5?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80";
      searchKey = "&dishtype=desserts";
      theListOfLinks = _listOfVegetables;
      theListOfNames = _listItemNamesOfVegetables;
    }


    SystemChrome.setEnabledSystemUIOverlays([]);
    final myController = TextEditingController();
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentScope = FocusScope.of(context);
        if (!currentScope.hasPrimaryFocus) {
          FocusScope.of(context).unfocus();
        }
      },
      child: MediaQuery(
        data: const MediaQueryData(),
        child: Scaffold(
          backgroundColor: const Color.fromRGBO(255, 245, 239, 1),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      Padding(
                          padding: EdgeInsets.all(width * 0.04),
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back,
                              color: color,
                              size: 30,
                            ),
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 15, 0, 15),
                        child: Text(widget.type,
                            style: TextStyle(
                                fontSize: height * 0.05,
                                color: color,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Container(
                    height: height * 0.25,
                    width: width * 0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: color, width: 2, style: BorderStyle.solid),
                        image: DecorationImage(
                            image: NetworkImage(image), fit: BoxFit.cover)),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          width * 0.03, padding, width * 0.4, 0),
                      child: Text(
                        headerName,
                        style: GoogleFonts.pacifico(
                          color: Colors.white,
                          height: 1.5,
                          fontSize: height * 0.05,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(width * 0.1, 8, 0, 15),
                        child: Container(
                            width: width * 0.75,
                            height: height * 0.06,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(width * 0.06),
                              color: Colors.grey[300],
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(width * 0.03,
                                        height * 0.02, width * 0.03, 8),
                                    child: GestureDetector(
                                      child: TextField(
                                        controller: myController,
                                        autofocus: false,
                                        onSubmitted: (value) {
                                          myController.text = value;
                                        },
                                        decoration: InputDecoration(
                                          hintText:
                                              searchKey.length >=8 ? "Search ${searchKey.substring(8, searchKey.length)} recipes..." : "Search recipes...",
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, height * 0.01),
                        child: IconButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoadingForSearch(
                                          "https://api.edamam.com/search?q=${myController.text}&app_id=efc2eac7&app_key=85cbbe554ef1744a97197b77b18ee242&from=1&to=101&calories=591-722$searchKey", color, myController.text))
                              );
                            },
                            icon: Icon(
                              Icons.search,
                              size: width * 0.08,
                            )),
                      )
                    ],
                  ),
                  SizedBox(
                    height: height * 0.035,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(width * 0.15),
                            topLeft: Radius.circular(width * 0.15))),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                          width * 0.03, height * 0.05, width * 0.03, 0),
                      child: GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        children: theListOfLinks
                            .map((item) => Card(
                                  color: Colors.transparent,
                                  elevation: 0,
                                  child: GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => LoadingForSearch(
                                                  "https://api.edamam.com/search?q=${theListOfNames[theListOfLinks.indexOf(item)]}&app_id=efc2eac7&app_key=85cbbe554ef1744a97197b77b18ee242&from=1&to=101&calories=591-722$searchKey", color, theListOfNames[theListOfLinks.indexOf(item)]))
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.grey[200],
                                          border: Border.all(color: color.withRed(200), width: 5, style: BorderStyle.solid),
                                          borderRadius: BorderRadius.circular(
                                              width * 0.07),
                                          image: DecorationImage(
                                              image: NetworkImage(item),
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
