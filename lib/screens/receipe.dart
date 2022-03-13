
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:share_plus/share_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:untitled2/datas/details.dart';
import 'package:untitled2/providers/last_viewed.dart';
import 'package:untitled2/datas/ingredients_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:untitled2/widgets/comments.dart';
import '../providers/favourites_list.dart';

import 'ingredients_show_off.dart';


class Receipe extends StatefulWidget {

  details? detail;

  Receipe(this.detail, {Key? key}) : super(key: key);
  @override
  State<Receipe> createState() => _ReceipeState();
}

class _ReceipeState extends State<Receipe> with SingleTickerProviderStateMixin{

  String ingredients = "";


  String cuisinesUsed = "";

  int number = 0;

  List<TableRow> tableInfoDigest = [];

  getTotalDaily(){
    print("getTotalDaily");
    widget.detail!.digest != null ? widget.detail!.digest!.forEach((value) {
      tableInfoDigest.add(
          TableRow(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    value['label'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.brown[900],
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${value["total"].toInt()} ${value["unit"]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.brown[900],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                )
              ]
          )
      );
    },

    ) : print("empty");
  }

  getIngredients() async{
    int count = 1;

    for (var i = 0; i < widget.detail!.ingredients!.length; i++){
      ingredients += "$count ${widget.detail!.ingredients![i]} \n";
      count++;
    }
    print("${widget.detail!.cuisine} cuisine");
    if(widget.detail!.cuisine !=null) {
      print("cuisine ran");
      for (var i = 0; i < widget.detail!.cuisine!.length; i++) {
        widget.detail!.cuisine!.length == 1 || cuisinesUsed == "" ?
        cuisinesUsed += widget.detail!.cuisine![i] : cuisinesUsed +=
        ", ${widget.detail!.cuisine![i]}";
      }
    }

    final url = await http.get(Uri.parse(widget.detail!.image!.substring(0, widget.detail!.image!.length-4) + "-l.jpg"));

    setState(() {
      if(url.statusCode == 200){
        number = 200;
      } else{
        number = 0;
      }
    });
  }
  List<dynamic>? commentsList;

  Comments? comments;

  String? profilePicture;

  getComments()async{

    print("${widget.detail!.label!}*&&&&");
    print("****");
    String uri;
    if(widget.detail!.type == "user") {
      uri = widget.detail!.uri!;
      print("widget.detail!.uri!");
    } else {
      uri = widget.detail!.uri!.substring(widget.detail!.uri!.indexOf("#recipe_"));
    }

    print(uri);


    await FirebaseFirestore.instance
        .collection("comments")
        .doc(uri).get().then((value){
      if(value.data()!= null) {
        commentsList = value.data()!["comments"];
      }else{
        commentsList = [];
      }

    });

    if(commentsList != []){
      comments = Comments(friendsList: commentsList);
    }


  }


  bool isLiked = false;


  @override
  void initState() {

    super.initState();
    getIngredients();
    getComments();
    getTotalDaily();
  }

  TextEditingController controller = TextEditingController();

  User user = FirebaseAuth.instance.currentUser!;
  IconData icon = Icons.keyboard_arrow_down;
  String tableName = "Open Nutrients";


  @override
  Widget build(BuildContext context) {

    SystemChrome.setEnabledSystemUIOverlays([]);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    IngredientsList ingredientsList = IngredientsList(widget.detail!);
    bool checkFav = Provider.of<Favourite>(context).getFavList().contains(widget.detail!) ? true : false;
    print(widget.detail!.totalDaily);
    print("##%^&*");
    print(widget.detail!.digest);
    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: MediaQuery(
        data: const MediaQueryData(),
        child: Scaffold(
          backgroundColor: Color.fromRGBO(250, 255, 250 ,1),
            floatingActionButton: Stack(
                children: [
                  Positioned(
                    top: 40,
                    left: 30,
                    child: Consumer<LastViewed>(
                      builder: (context, lastViewed, child) => FloatingActionButton(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        heroTag: "hero1",
                        child: (
                            const Icon(
                                Icons.arrow_back_ios_sharp,
                              color: Colors.pink,
                              size: 40,
                            )
                        ),
                        onPressed: (){
                          if(number == 200){
                            widget.detail!.checker(200);
                          }
                          print("${widget.detail!.label}&&&&&***%%");
                          print("${widget.detail!.description}&&&&&***%%");
                          lastViewed.addReceipe(widget.detail!);
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                  Consumer<Favourite>(
                    builder: (context, favouriteList, child) => Positioned(
                      top: 40,
                      right: 0,
                      child: FloatingActionButton(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        heroTag: "hero2",
                        child: (
                            Icon(
                              checkFav == true ? Icons. favorite : Icons.favorite_border_outlined,
                              color: Colors.pink,
                              size: 40,
                            )
                        ),
                        onPressed: ()async{
                          var id = await FirebaseAuth.instance.currentUser!.uid;
                          FirebaseFirestore.instance.collection("users").doc("$id");
                          print("${widget.detail!.mediumImage}%%%");
                          setState(() {
                            favouriteList.getFavList().contains(widget.detail!) ? favouriteList.deleteFavourites(widget.detail!) : favouriteList.addFavourites(widget.detail!);
                          });
                          
                          },
                      ),
                    ),
                  ),
                ],
              ),
            body: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          children: [
                            Container(
                                height: height*0.4,
                                width: width,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      number == 200 ? widget.detail!.image!.substring(0, widget.detail!.image!.length-4) + "-l.jpg" : widget.detail!.image!,
                                      scale: 0.1,
                                    ),
                                    fit: BoxFit.cover
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0,height*0.37,0,0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color:  Color.fromRGBO(250, 255, 250 ,1),
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(width*0.1),
                                            topRight: Radius.circular(width*0.1)
                                        )
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(width*0.25, height*0.015, width*0.25, height*0.01),
                                      child: SizedBox(
                                        width: 10,
                                        height: 10,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius: BorderRadius.circular(width*0.005)
                                          ),
                                        ),
                                      ),
                                    )
                                  ),
                                ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(28, 10, 8, 0),
                              child: Text(
                                widget.detail!.label!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: width*0.07,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                                    child: RichText(
                                        text: cuisinesUsed.isNotEmpty ? TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "From:",
                                              style: TextStyle(
                                                  fontSize: height*0.02,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            TextSpan(
                                              text:" $cuisinesUsed cuisine!",
                                              style: TextStyle(
                                                  fontSize: height*0.02,
                                                  color: Colors.brown[900],
                                                  fontStyle: FontStyle.italic
                                              ),
                                            ),
                                          ],
                                        ) : TextSpan(
                                          children: [
                                            TextSpan(
                                              text: "  From: ",
                                              style: TextStyle(
                                                  fontSize: height*0.02,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            TextSpan(
                                              text:"No specific cuisines!",
                                              style: TextStyle(
                                                  fontSize: height*0.02,
                                                  color: Colors.brown[900],
                                                  fontStyle: FontStyle.italic
                                              ),
                                            ),
                                          ],
                                        )
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(8, 3, 8, 0),
                                    child: Row(
                                      children: [
                                        Icon(
                                            CupertinoIcons.checkmark_alt,
                                          size: width*0.08,
                                        ),
                                        widget.detail!.totalTime! != 0 ? Text(" under ${widget.detail!.totalTime!} minutes", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900,fontStyle: FontStyle.italic, letterSpacing: 2),) : const Text("Not available", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900,fontStyle: FontStyle.italic, letterSpacing: 2)),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(0, 30, 25, 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          width: width*0.6,
                                          child: FittedBox(
                                            child: Text(
                                              "List of ingredients!",
                                              style: TextStyle(
                                                fontSize: height*0.035,
                                                fontWeight: FontWeight.w300,
                                                fontStyle: FontStyle.italic
                                              ),
                                            ),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => IngredientsShowOff(widget.detail!)));
                                          },
                                          child: Container(
                                            width: width*0.22,
                                            height: 30,
                                            decoration: BoxDecoration(
                                                color: Colors.pink,
                                                borderRadius: BorderRadius.all(Radius.circular(10))
                                            ),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(
                                                    "preview",
                                                  style: TextStyle(
                                                    color: Colors.pink[100],
                                                    fontSize: 15,
                                                    fontStyle: FontStyle.italic,
                                                    letterSpacing: 2
                                                  ),
                                                ),
                                                Icon(
                                                    CupertinoIcons.arrowtriangle_right_fill,
                                                    color: Colors.grey[200],
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: height*0.01,),
                            ingredientsList,
                            SizedBox(height: height*0.005,),
                            const Divider(height: 1,),
                            SizedBox(height: height*0.005,),

                            widget.detail!.digest != null ? Container(
                              margin: EdgeInsets.all(20),
                              child: ExpansionTile(
                                onExpansionChanged: ((newState){
                                  print("changed");
                                  setState(() {
                                    icon = icon == Icons.keyboard_arrow_up ? Icons.keyboard_arrow_down: Icons.keyboard_arrow_up;
                                    tableName = tableName == "Open Nutrients" ? "Close Nutrients":"Open Nutrients";
                                  });
                                }),
                                title: Column(
                                  children: [
                                    Text(
                                      tableName,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.pinkAccent
                                      ),
                                    ),
                                    Icon(
                                      icon,
                                        color: Colors.pinkAccent
                                    )
                                  ],
                                ),
                                trailing: Text(""),
                                children: [
                                  Table(
                                      defaultColumnWidth: FixedColumnWidth(width/2),
                                      border: TableBorder.all(
                                          color: Colors.grey, style: BorderStyle.solid, width: 1,borderRadius: BorderRadius.all(Radius.circular(10))),

                                      children: tableInfoDigest
                                  ),
                                ],
                              ),
                            ) : Container(),
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(height*0.02),
                                  child: ListTile(
                                    title: Text(
                                      "Comments",
                                      style: TextStyle(
                                          fontSize: height*0.03,
                                          color: Colors.grey[700]
                                      ),
                                    ),
                                  )
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      height: 50,
                                      width: width,
                                      child: Container(
                                        width: width-50,
                                        child: TextFormField(
                                          controller: controller,
                                          decoration: InputDecoration(
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(15.0),
                                            ),
                                            label: Text("Comment", style: TextStyle(fontSize: 20),),
                                            alignLabelWithHint: true,
                                            suffixIconColor: controller.text.isEmpty?Colors.grey:Colors.red,
                                            hintText: ". . .",
                                            suffixText: "Reply",
                                            suffixIcon: Padding(
                                              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.comment,
                                                  size: width*0.07,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () async{

                                                  if(controller.value.text != ''){


                                                    bool exist = false;

                                                    String uri;
                                                    if(widget.detail!.type == "user") {
                                                      uri = widget.detail!.uri!;
                                                    } else {
                                                      uri = widget.detail!.uri!.substring(widget.detail!.uri!.indexOf("#recipe_"));
                                                    }

                                                    bool checker = false;
                                                    await FirebaseFirestore.instance.collection("comments")
                                                        .doc(uri)
                                                        .get()
                                                        .then((doc) async {
                                                      if(doc.exists){
                                                        checker = true;
                                                      }else{
                                                        checker = false;
                                                      }
                                                    });
                                                    String minute = '';
                                                    if(DateTime.now().minute<10){
                                                      minute = "0${DateTime.now().minute}";
                                                    }else{
                                                      minute = "${DateTime.now().minute}";
                                                    }
                                                    if(checker == false) {

                                                      await FirebaseFirestore.instance
                                                          .collection("comments")
                                                          .doc(uri).set({
                                                        "comments":[
                                                          {
                                                            'name': user.displayName,
                                                            'comment': controller.value.text,
                                                            'email': user.email,
                                                            'date': {
                                                              'day': "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                                              'time': "${DateTime.now().hour}:${minute}"
                                                            },
                                                            'uid': FirebaseAuth.instance.currentUser!.uid
                                                          }
                                                        ]
                                                      });
                                                      controller.clear();
                                                      setState(() {

                                                      });
                                                    }else{
                                                      List<dynamic>? friendsList;

                                                      await FirebaseFirestore.instance
                                                          .collection("comments")
                                                          .doc(uri).get().then((value){
                                                        friendsList = value.data()!["comments"];
                                                        friendsList!.add({
                                                          'name':user.displayName,
                                                          'comment':controller.value.text,
                                                          'email': user.email,
                                                          'date': {
                                                            'day': "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                                            'time': "${DateTime.now().hour}:${minute}"
                                                          },
                                                          'uid': FirebaseAuth.instance.currentUser!.uid
                                                        });

                                                      });
                                                      await FirebaseFirestore.instance
                                                          .collection("comments")
                                                          .doc(uri).set({'comments':friendsList!}) ;
                                                      controller.clear();
                                                      setState(() {

                                                      });
                                                    }
                                                  }
                                                },
                                              ),
                                            ),
                                          ),

                                        ),
                                      ),
                                    ),
                                  ),
                                  FutureBuilder(
                                    future: getComments(),
                                      builder: (context, snapshot){
                                        if(snapshot.connectionState == ConnectionState.waiting){
                                          return Center(
                                              child: Container(
                                                height: height/2,
                                                  width: width,
                                                  child: Center(child: CircularProgressIndicator(strokeWidth: 5,))
                                              )
                                          );
                                        } else {
                                          return comments != null ? comments!
                                              : Container(
                                                width: width,
                                                height: width/2,
                                                child: Center(child: Text("Empty")),
                                          );
                                        }
                                      }
                                  ),
                                  FutureBuilder(
                                    future: getComments(),
                                    builder: (context, snapshot) {
                                      if(snapshot.connectionState == ConnectionState.waiting){
                                        return Center(child: CircularProgressIndicator(),);
                                      }
                                      return SizedBox(
                                        height: height/3,
                                      );
                                    }
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                        Container(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      Share.share(widget.detail!.url!, subject: "Check out this recipe!");
                                    },
                                    child: Container(
                                      child: Text(
                                          "Click to share!",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.pacifico(
                                            color: Colors.black,
                                            height: height*0.0013,
                                            fontSize: height*0.045,
                                          )
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 200,)
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                  ),
                ),
        ),
      ),
    );
  }
}
