
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled2/datas/details.dart';
import 'package:untitled2/datas/user_recipes_details.dart';
import 'package:untitled2/loading/loading.dart';
import 'package:untitled2/screens/receipe.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:untitled2/screens/user_recipe.dart';

class CardUserRecipes extends StatefulWidget {
  UserRecipesDetails? detail;
  String image = "https://www.edamam.com/web-img/7a2/7a2f41a7891e8a8f8a087a96930c6463.jpg";
  String label = "name of the meal";
  Color? color;

  CardUserRecipes(UserRecipesDetails? detail, Color? color, {Key? key}) : super(key: key){
    this.detail = detail!;
    this.image = detail.image!;
    this.label = detail.title!;
    this.color = color!;
  }
  @override
  State<CardUserRecipes> createState() => _CardUserRecipesState();
}

class _CardUserRecipesState extends State<CardUserRecipes> {
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GestureDetector(
        onTap: () {
          Navigator.push(
              (context),
              MaterialPageRoute(
                  builder: (context) => UserRecipe(widget.detail!)
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
                shadowColor: Colors.pink,
                semanticContainer: true,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 5,
                margin:  EdgeInsets.all(width*0.025),
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.white70, width: 0),
                  borderRadius: BorderRadius.circular(width*0.08),
                ),
                child: Container(
                  color: widget.color,
                  child: Column(
                    children: [
                      Container(
                        height: width*0.45,
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
                      FittedBox(
                        child: Column(
                          children: [
                            SizedBox(height: height*0.01,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                    children:[
                                      Row(
                                        children: [
                                          const Icon(
                                            Icons.access_alarm_outlined,
                                            color: Colors.white,
                                          ),
                                          widget.detail!.totalTime == 0
                                              ? Text("NA", style: TextStyle(fontSize: height*0.02, color: Colors.white),)
                                              : Text(" ${widget.detail!.totalTime}", style: TextStyle(fontSize: height*0.02, color: Colors.white),)
                                        ],
                                      )
                                    ]
                                ),
                                Column(
                                    children:[
                                      Row(
                                        children: [
                                          const Icon(
                                              Icons.add_task_rounded,
                                              color: Colors.white
                                          ),
                                          Text(" ${widget.detail!.calories} kcal",  style: TextStyle(fontSize: height*0.02, color: Colors.white))
                                        ],
                                      )
                                    ]
                                ),
                                Column(
                                    children:[
                                      Row(
                                        children: [
                                          const Icon(
                                              Icons.accessibility,
                                              color: Colors.white
                                          ),
                                          Text("${widget.detail!.protein} gr protein",  style: TextStyle(fontSize: height*0.02, color: Colors.white))
                                        ],
                                      )
                                    ]
                                )
                              ],
                            ),
                          ],
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
