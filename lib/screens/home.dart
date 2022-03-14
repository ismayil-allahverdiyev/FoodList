
import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:untitled2/datas/details.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/providers/last_viewed.dart';
import 'package:untitled2/screens/add_recipe_page.dart';
import 'package:flutter/services.dart';
import 'package:untitled2/loading/loading_for_search.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled2/screens/profile.dart';
import 'package:untitled2/screens/receipe.dart';
import 'package:untitled2/services/authentication_service.dart';
import '../widgets/card.dart';
import 'selective.dart';
import '../providers/favourites_list.dart';

class Home extends StatefulWidget {

  List<details> allreceipes = [];

  List<details> favReceipes = [];

  Home(this.allreceipes, this.favReceipes, {Key? key}) : super(key: key);
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<details> suggestions = [];

  randomize(List<details> recipes){
    var randomList = [];
    for(int i = 0; i < recipes.length; i++){
      Random random = new Random();
      int randomNumber = random. nextInt(recipes.length);
      while(randomList.contains(randomNumber)){
        randomNumber = random. nextInt(recipes.length);
      }
      randomList.add(randomNumber);

      suggestions.add(recipes.elementAt(randomNumber));
    }
  }

  String reloader = "";

  final List<String> dietList = [
    "choose",
    "balanced",
    "high-fiber",
    "high-protein",
    "low-carb",
    "low-fat",
    "low-sodium"
  ];

  final healthLabelsList = [
    "alcohol-cocktail",
    "alcohol-free",
    "dairy-free",
    "gluten-free",
    "immuno-supportive",
    "keto-friendly",
    "kidney-friendly",
    "low-sugar",
    "mustard-free",
    "no-oil-added",
    "peanut-free",
    "pork-free",
    "tree-nut-free",
    "vegan",
    "vegetarian",
  ];

  final cuisineTypeList = [
    "choose",
    "American",
    "Asian",
    "British",
    "Caribbean",
    "Chinese",
    "French",
    "Indian",
    "Italian",
    "Japanese",
    "Kosher",
    "Mediterranean",
    "Mexican",
    "Nordic",
    "Middle Eastern",
    "South American",
    "South East Asian",
    "Eastern Europe",
    "Central Europe",
  ];

  ScrollController recentRecipesController = ScrollController();

  String? _name;
  String _imageUrl = "";
  List? favList;
  String? _id;

  void getData() async{
    User user = context.read<AuthenticationService>().getUser()!;
    setState(() {
      _id = user.uid;
    });
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection("users").doc(_id).get();
    setState(() {
      _name = userDoc.get("name");
      _imageUrl = userDoc.get("imageUrl");
      favList = userDoc.get("favorites");
    });
    Provider.of<Favourite>(context, listen: false).takeFirebaseFavs();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    randomize(widget.allreceipes);

  }

  String choiceForDiet = "";
  String choiceForHealth = "";

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {


    setState(() {

    });

    String hintHealth = "Health";
    SystemChrome.setEnabledSystemUIOverlays([]);

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: GestureDetector(
        onTap: (){
          FocusScopeNode currentFocus = FocusScope.of(context);
          if(!currentFocus.hasPrimaryFocus){
            currentFocus.unfocus();
          }
        },
        child: MediaQuery(
          data: const MediaQueryData(),
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
                backgroundColor: const Color.fromRGBO(143, 133, 125, 1),
                appBar: AppBar(
                  actions: [
                    IconButton(
                      icon:const Icon(Icons.power_settings_new),
                      onPressed: (){
                        SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                      },
                    )
                  ],
                  backgroundColor: const Color.fromRGBO(119, 118, 188, 1),
                  elevation: 0,
                ),
                drawer: Builder(
                    builder: (context2) {
                      return Drawer(
                        child: ListView(
                          children: [
                            ListTile(
                              leading: Icon(Icons.account_circle),
                              title: const Text('Profile'),
                              onTap: (){
                                unawaited(Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => Profile())).then((_) => setState(() {})));
                                Navigator.pop(context2);
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.post_add_sharp),
                              title: const Text('Add Recipe'),
                              onTap: () {
                                Navigator.pop(context2);
                                Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => AddRecipePage())).then((_) => setState(() {}));
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.logout),
                              title: const Text('Sign out'),
                              onTap: () {
                                context.read<AuthenticationService>().signOut();
                              },
                            ),
                          ],
                        ),
                      );
                    }
                ),
                body: SafeArea(
                  child: Container(
                    color: const Color.fromRGBO(255, 245, 239, 1),
                    child: SingleChildScrollView(
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                color: Color.fromRGBO(119, 118, 188, 1),
                                borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(15),
                                    bottomLeft: Radius.circular(15)
                                )
                            ),
                            child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => Selective("Vegetarian")));
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: const Color.fromRGBO(235, 130, 88, 1),
                                            // backgroundImage: const AssetImage("assets/color4.jpg"),
                                            radius: width*0.095,
                                            child: Hero(
                                              tag: "vegetarian",
                                              child: CircleAvatar(
                                                backgroundImage: const NetworkImage("https://images.unsplash.com/photo-1597362925123-77861d3fbac7?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MjZ8fHZlZ2V0YWJsZXxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60"),
                                                radius: width*0.085,
                                              ),
                                            ),
                                          )
                                      ),GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => Selective("Meat")));
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: const Color.fromRGBO(235, 130, 88, 1),
                                            // backgroundImage: const AssetImage("assets/color2.jpg"),
                                            radius: width*0.095,
                                            child: Hero(
                                              tag: "meat",
                                              child: CircleAvatar(
                                                backgroundImage: const NetworkImage("https://images.unsplash.com/photo-1551028150-64b9f398f678?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OHx8bWVhdCUyMGFuZCUyMGNoaWNrZW58ZW58MHx8MHx8&auto=format&fit=crop&w=500&q=60"),
                                                radius: width*0.085,
                                              ),
                                            ),
                                          )
                                      ),GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => Selective("Seafood")));
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: const Color.fromRGBO(235, 130, 88, 1),
                                            // backgroundImage: AssetImage("assets/color3.jpg"),
                                            radius: width*0.095,
                                            child: Hero(
                                              tag: "seafood",
                                              child: CircleAvatar(
                                                backgroundImage: const NetworkImage("https://images.unsplash.com/photo-1518732751612-2c0787ff5684?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8OXx8Y29va2VkJTIwZmlzaHxlbnwwfHwwfHw%3D&auto=format&fit=crop&w=500&q=60"),
                                                radius: width*0.085,
                                              ),
                                            ),
                                          )
                                      ),GestureDetector(
                                          onTap: (){
                                            Navigator.push(context, MaterialPageRoute(builder: (context) => Selective("Desserts")));
                                          },
                                          child: CircleAvatar(
                                            backgroundColor: const Color.fromRGBO(235, 130, 88, 1),
                                            // backgroundImage: AssetImage("assets/color.jpg"),
                                            radius: width*0.095,
                                            child: Hero(
                                              tag: "dessert",
                                              child: CircleAvatar(
                                                backgroundImage: const NetworkImage("https://images.unsplash.com/photo-1551024601-bec78aea704b?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mjd8fGRlc3NlcnRzfGVufDB8fDB8fA%3D%3D&auto=format&fit=crop&w=500&q=60"),
                                                radius: width*0.085,
                                              ),
                                            ),
                                          )
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(8, 20, 8, 20),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: width*0.13,
                                          width: width*0.8,
                                          child: Card(
                                            elevation: 10,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(Radius.circular(15)),
                                            ),
                                            child: Center(
                                              child: TextField(
                                                controller: myController,
                                                decoration: InputDecoration(
                                                  hintText: "Search recipes",
                                                  floatingLabelStyle: TextStyle(
                                                    color: Color(0xff27a5a1),
                                                    fontSize: height*0.025,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1.5,
                                                  ),
                                                  hintStyle: TextStyle(
                                                    color: const Color(0xff00798c),
                                                    fontSize: height*0.02,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1.5,
                                                  ),
                                                  focusedBorder: const OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                                      borderSide: BorderSide(color: Colors.white, style: BorderStyle.none, width: 0)
                                                  ),
                                                  disabledBorder: const OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                                      borderSide: BorderSide(color: Colors.white, style: BorderStyle.none, width: 0)
                                                  ),
                                                  enabledBorder: const OutlineInputBorder(
                                                      borderRadius: BorderRadius.all(Radius.circular(10)),
                                                      borderSide: BorderSide(color: Colors.white, style: BorderStyle.none, width: 0)
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(0,0,0,height*0.01),
                                          child: IconButton(
                                              onPressed: ()async{
                                                Navigator.push(
                                                    context,
                                                    await MaterialPageRoute(
                                                        builder: (context)
                                                        => LoadingForSearch(
                                                            "https://api.edamam.com/search?q=${myController.text}&app_id=efc2eac7&"
                                                                "app_key=85cbbe554ef1744a97197b77b18ee242&from=1&to=101&calories=591-722$choiceForHealth", const Color.fromRGBO(119, 118, 188, 1), myController.text)
                                                    )
                                                );
                                                print(choiceForHealth);
                                              },
                                              icon: Icon(
                                                Icons.search,
                                                color: const Color.fromRGBO(255, 255, 242, 1),
                                                size: width*0.1,
                                              )
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  // Padding(
                                  //   padding: EdgeInsets.fromLTRB(0, 0, width*0.3, 10),
                                  //   child: Text(
                                  //     "Recent recipes",
                                  //     textAlign: TextAlign.start,
                                  //     style: TextStyle(
                                  //       fontStyle: FontStyle.italic,
                                  //         color: Colors.white,
                                  //         fontWeight: FontWeight.w500,
                                  //         fontSize: width*0.05,
                                  //         letterSpacing: 2
                                  //     ),
                                  //   ),
                                  // ),
                                  // SingleChildScrollView(
                                  //   controller: recentRecipesController,
                                  //   child: SizedBox(
                                  //     width: width*0.91,
                                  //     height: width*0.6+10,
                                  //     child: TweenAnimationBuilder(
                                  //       duration: const Duration(seconds: 2),
                                  //       tween: Tween<double>(begin: 0, end: 1),
                                  //       builder: (BuildContext context, double value, Widget? child){
                                  //         return Opacity(
                                  //             opacity: value,
                                  //           child: Padding(
                                  //             padding: EdgeInsets.fromLTRB(0,value*10,0,0),
                                  //             child: child,
                                  //           ),
                                  //         );
                                  //       },
                                  //       child: Consumer<LastViewed>(
                                  //         builder: (context, lastViewed, child) => ListView.builder(
                                  //           scrollDirection: Axis.horizontal,
                                  //             itemCount: lastViewed.lastViewedReceipes.isEmpty ? 1 : lastViewed.lastViewedReceipes.length,
                                  //             itemBuilder: (context, i){
                                  //               return GestureDetector(
                                  //                 onTap: (){
                                  //                   lastViewed.lastViewedReceipes.isNotEmpty ? Navigator.push(context, MaterialPageRoute(builder: (context) => Receipe(lastViewed.lastViewedReceipes[lastViewed.lastViewedReceipes.length-i -1]))) : print("");
                                  //                 },
                                  //                 child: Card(
                                  //                   elevation: 5,
                                  //                   shape: RoundedRectangleBorder(
                                  //                     borderRadius: BorderRadius.circular(width*0.1),
                                  //                   ),
                                  //                   child: Container(
                                  //                     height: height*0.25,
                                  //                     width: width*0.9,
                                  //                     decoration: BoxDecoration(
                                  //                       border: Border.all(color: const Color.fromRGBO(190, 118, 188, 1), style: BorderStyle.solid, width: 2),
                                  //                       borderRadius: BorderRadius.circular(width*0.1),
                                  //                       image: DecorationImage(
                                  //                           image: lastViewed.lastViewedReceipes.isEmpty ?
                                  //                           const NetworkImage("https://images.unsplash.com/photo-1514536958296-"
                                  //                               "436f46226e74?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8f"
                                  //                               "GVufDB8fHx8&auto=format&fit=crop&w=1170&q=80") :
                                  //                           lastViewed.lastViewedReceipes[lastViewed.lastViewedReceipes.length-i -1].httpNumber == 200 ? NetworkImage(lastViewed.lastViewedReceipes[lastViewed.lastViewedReceipes.length-i -1].image!.substring(0, lastViewed.lastViewedReceipes[lastViewed.lastViewedReceipes.length-i -1].image!.length-4) + "-l.jpg"): NetworkImage(lastViewed.lastViewedReceipes[lastViewed.lastViewedReceipes.length-i -1].image!) as ImageProvider,
                                  //                           scale: 2,
                                  //                           fit: BoxFit.cover
                                  //                       ),
                                  //                     ),
                                  //                     child: Padding(
                                  //                       padding: EdgeInsets.fromLTRB(width*0.4,height*0.02,width*0.06, 0),
                                  //                       child: Column(
                                  //                         mainAxisAlignment: MainAxisAlignment.center,
                                  //                         crossAxisAlignment: CrossAxisAlignment.center,
                                  //                         children: [
                                  //                           Text(
                                  //                             lastViewed.lastViewedReceipes.isEmpty ? "Check some recipes" : lastViewed.lastViewedReceipes[lastViewed.lastViewedReceipes.length-i-1].label!.substring(0, lastViewed.lastViewedReceipes[lastViewed.lastViewedReceipes.length-i-1].label!.length > 20 ? 20 : lastViewed.lastViewedReceipes[lastViewed.lastViewedReceipes.length-i-1].label!.length) + "...",
                                  //                             style: GoogleFonts.pacifico(
                                  //                                 color: Colors.white,
                                  //                                 height: height*0.0013,
                                  //                                 fontSize: height*0.045,
                                  //
                                  //                             ),
                                  //                             maxLines: 3,
                                  //                             textAlign: TextAlign.center,
                                  //                           ),
                                  //                         ],
                                  //                       ),
                                  //                     ),
                                  //                   ),
                                  //                 ),
                                  //               );
                                  //             }
                                  //         ),
                                  //       ),
                                  //     ),
                                  //   ),
                                  // ),
                                  SizedBox(height: height*0.01,),
                                ]
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage('assets/images/adsiz.png'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(width*0.05, width*0.05, width*0.3, 10),
                                  child: Text(
                                    "Recent recipes",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Color.fromRGBO(119, 118, 188, 1),
                                        fontWeight: FontWeight.w500,
                                        fontSize: width*0.06,
                                        letterSpacing: 2
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(0,0,0,0),
                                  child: SingleChildScrollView(
                                    controller: recentRecipesController,
                                    child: SizedBox(
                                      width: width,
                                      height: width*0.6+10,
                                      child: TweenAnimationBuilder(
                                        duration: const Duration(seconds: 2),
                                        tween: Tween<double>(begin: 0, end: 1),
                                        builder: (BuildContext context, double value, Widget? child){
                                          return Opacity(
                                            opacity: value,
                                            child: Padding(
                                              padding: EdgeInsets.fromLTRB(0,value*10,0,0),
                                              child: child,
                                            ),
                                          );
                                        },
                                        child: Consumer<LastViewed>(
                                          builder: (context, lastViewed, child) => ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: lastViewed.lastViewedReceipes.isEmpty ? 1 : lastViewed.lastViewedReceipes.length,
                                              itemBuilder: (context, i){
                                                return GestureDetector(
                                                  onTap: (){
                                                    lastViewed.lastViewedReceipes.isNotEmpty ? Navigator.push(context, MaterialPageRoute(builder: (context) => Receipe(lastViewed.lastViewedReceipes[lastViewed.lastViewedReceipes.length-i -1]))) : print("");
                                                  },
                                                  child: Padding(
                                                    padding: EdgeInsets.fromLTRB(width*0.04, 0, width*0.0,0),
                                                    child: Card(
                                                      elevation: 5,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(width*0.05),
                                                      ),
                                                      child: Container(
                                                        height: height*0.25,
                                                        width: width*0.91,
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: Color.fromRGBO(119, 118, 188, 1), style: BorderStyle.solid, width: 5),
                                                          borderRadius: BorderRadius.circular(width*0.05),
                                                          image: DecorationImage(
                                                              image: lastViewed.lastViewedReceipes.isEmpty ?
                                                              const NetworkImage("https://images.unsplash.com/photo-1514536958296-"
                                                                  "436f46226e74?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8f"
                                                                  "GVufDB8fHx8&auto=format&fit=crop&w=1170&q=80") :
                                                              lastViewed.lastViewedReceipes[lastViewed.lastViewedReceipes.length-i -1].httpNumber == 200 ? NetworkImage(lastViewed.lastViewedReceipes[lastViewed.lastViewedReceipes.length-i -1].image!.substring(0, lastViewed.lastViewedReceipes[lastViewed.lastViewedReceipes.length-i -1].image!.length-4) + "-l.jpg"): NetworkImage(lastViewed.lastViewedReceipes[lastViewed.lastViewedReceipes.length-i -1].image!) as ImageProvider,
                                                              scale: 2,
                                                              fit: BoxFit.cover
                                                          ),
                                                        ),
                                                        child: Padding(
                                                          padding: EdgeInsets.fromLTRB(width*0.4,height*0.02,width*0.06, 0),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.center,
                                                            crossAxisAlignment: CrossAxisAlignment.center,
                                                            children: [
                                                              Text(
                                                                lastViewed.lastViewedReceipes.isEmpty ? "Check some recipes" : lastViewed.lastViewedReceipes[lastViewed.lastViewedReceipes.length-i-1].label!.substring(0, lastViewed.lastViewedReceipes[lastViewed.lastViewedReceipes.length-i-1].label!.length > 20 ? 20 : lastViewed.lastViewedReceipes[lastViewed.lastViewedReceipes.length-i-1].label!.length) + "...",
                                                                style: GoogleFonts.pacifico(
                                                                  color: Colors.white,
                                                                  height: height*0.0013,
                                                                  fontSize: height*0.045,

                                                                ),
                                                                maxLines: 3,
                                                                textAlign: TextAlign.center,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: height*0.02,),
                                Padding(
                                  padding:  EdgeInsets.fromLTRB(width*0.1,0,0,0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(119, 118, 188, 1),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(height*0.015, height*0.015, height*0.015, height*0.015),
                                      child: Text(
                                        "Suggestions",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: width*0.04,
                                            letterSpacing: 2
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                        width: width,
                                        height: width*0.55,
                                        child: ListView.builder(
                                            itemCount: widget.allreceipes.length,
                                            scrollDirection: Axis.horizontal,
                                            itemBuilder: (context, index){
                                              return card(suggestions[index], suggestions[index].image,suggestions[index].label, const Color.fromRGBO(119, 118, 188, 1));
                                            }
                                        )
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.fromLTRB(width*0.1,0,0,0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: Color.fromRGBO(119, 118, 188, 1),
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(height*0.015, height*0.015, height*0.015, height*0.015),
                                      child: Text(
                                        "Favourites",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: width*0.04,
                                            letterSpacing: 2
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Consumer<Favourite>(
                                  builder: (context, favouriteList, child) => Row(
                                    children: [
                                      SizedBox(
                                          width: width,
                                          height: favouriteList.getFavList().isEmpty ? height*0.1 : width * 0.55,
                                          child: favouriteList.getFavList().isEmpty ? Center(child: Text("Add recipes please", style: GoogleFonts.pacifico(color: Colors.black, height: height*0.0013, fontSize: height*0.045,),),) : ListView.builder(
                                              itemCount: favouriteList.getFavList().length,
                                              scrollDirection: Axis.horizontal,
                                              itemBuilder: (context, index){
                                                return card(favouriteList.getFavList()[index], favouriteList.getFavList()[index].image, favouriteList.getFavList()[index].label, const Color.fromRGBO(119, 118, 188, 1));
                                              }
                                          )
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
            ),
          ),
        ),
      ),
    );
  }
}

