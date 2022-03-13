import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/datas/user_recipes_details.dart';
import 'package:untitled2/loading/loading_for_search.dart';
import 'package:untitled2/widgets/card.dart';
import 'package:untitled2/widgets/card_user_recipes.dart';
import 'package:untitled2/widgets/search_card.dart';
import '../datas/details.dart';
import 'package:shimmer/shimmer.dart';


class SearchResults extends StatefulWidget {
  List<details> resultsList = [];
  String? searchKey;
  Color? color;
  SearchResults(this.resultsList, this.color,this.searchKey, {Key? key}) : super(key: key);
  @override
  _SearchResultsState createState() => _SearchResultsState();
}

class _SearchResultsState extends State<SearchResults> {
  List<dynamic>? listOfUserDescriptions;
  List<dynamic>? listOfUserRecipes;
  List<details> listOfUserRecipesInDetails = [];
  List<Widget> listOfUserRecipesInWidgets = [];

  getUserData()async{

    listOfUserRecipesInDetails = [];
    List<dynamic> tempList = [];
    List<int> searchNumbers = [];
    await FirebaseFirestore.instance.collection('userRecipes').
    doc('recipes').get().
    then((value){
      print("description ran");
      tempList = value["descriptions"];
        listOfUserDescriptions = tempList;
    });
    tempList.forEach((element) {
      if(element.toString().contains("${widget.searchKey!}")){
        if(!searchNumbers.contains(tempList.indexOf(element))){
          searchNumbers.add(tempList.indexOf(element));
          print(element);
        }
      }
    });
    List<dynamic> tempListDescriptions = [];
    await FirebaseFirestore.instance.collection('userRecipes').
    doc('recipes').get().
    then((value){
      print("recipe ran");
      listOfUserRecipesInDetails = [];
      tempListDescriptions = value["recipe"];
      listOfUserRecipes = tempListDescriptions;
      for(int i = 0; i<searchNumbers.length; i++){
        details detail = details(
          type: "user",
          uri: "${listOfUserRecipes![searchNumbers[i]]["uri"]}",
          image: listOfUserRecipes![searchNumbers[i]]["image"],
          protein: int.parse(listOfUserRecipes![searchNumbers[i]]["protein"]),
          ingredients: listOfUserRecipes![searchNumbers[i]]["ingredients"],
          cuisine: listOfUserRecipes![searchNumbers[i]]["cuisine"],
          totalTime: int.parse(listOfUserRecipes![searchNumbers[i]]["totalTime"]),
          calories: int.parse(listOfUserRecipes![searchNumbers[i]]["calories"]),
          label: listOfUserRecipes![searchNumbers[i]]["label"],
          description: listOfUserRecipes![searchNumbers[i]]["description"],
          dietLabels: listOfUserRecipes![searchNumbers[i]]["dietLabels"],
          healthLabels: listOfUserRecipes![searchNumbers[i]]["healthLabels"],
        );
        if(!listOfUserRecipesInDetails.contains(detail)){
          listOfUserRecipesInDetails.add(detail);
        }
      }
      listOfUserRecipesInWidgets = [];
      listOfUserRecipesInDetails.forEach((element) {
        print("building");
        print(element.image);
        if(!listOfUserRecipesInWidgets.contains(card(element,element.image,element.label, widget.color))) {
          listOfUserRecipesInWidgets.add(card(element,element.image,element.label, widget.color));
        }
      });
    });
    print("${listOfUserRecipesInWidgets.length} widgets");
    print("${listOfUserRecipesInDetails.length} details");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserData();
    print("I ran");
  }

  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async{
        return false;
      },
      child: GestureDetector(
        onTap: (){
          FocusScopeNode currentScope = FocusScope.of(context);
          if(!currentScope.hasPrimaryFocus){
            FocusScope.of(context).unfocus();
          }
        },
        child: MediaQuery(
          data: const MediaQueryData(),
          child: MaterialApp(
            color: Colors.purple,
            home: Scaffold(
              resizeToAvoidBottomInset: false,
              body: CustomScrollView(
                slivers: [
                  SliverList(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    delegate: SliverChildListDelegate([
                      Row(
                        children: [
                          IconButton(
                              onPressed: (){
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              icon: Icon(
                                  Icons.arrow_back_sharp,
                                  size: height*0.03,
                              )
                          ),
                          Flexible(
                            child: Padding(
                              padding:  EdgeInsets.fromLTRB(width*0.02,height*0.02,width*0.02, height*0.01),
                              child: GestureDetector(
                                child: TextField(
                                  controller: myController,
                                  decoration: InputDecoration(
                                    hintText: "Search Receipes...",
                                    hintStyle: TextStyle(
                                      fontSize: height*0.02
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                              onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => LoadingForSearch("https://api.edamam.com/search?q=${myController.text}&app_id=efc2eac7&app_key=85cbbe554ef1744a97197b77b18ee242&from=1&to=101&calories=591-722&health=alcohol-free", widget.color, myController.text)));
                              },
                              icon: Icon(
                                  Icons.search,
                                  size: height*0.03,
                              )
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 8, 0, 8),
                        child: Text(
                            "User recipes related to \"${widget.searchKey}\"",
                          style: TextStyle(
                            fontSize: height*0.02,
                            color: Colors.grey,
                            letterSpacing: 2
                          ),
                        ),
                      ),
                      SizedBox(
                        height: width*0.6,
                        width: width,
                        child: FutureBuilder(
                          future: getUserData(),
                          builder: (context, snapshot) {
                            if(snapshot.connectionState == ConnectionState.waiting){
                              return Shimmer.fromColors(
                                baseColor: Colors.grey[300]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  width: width,
                                  height: height*0.6,
                                  child: Center(
                                    child: ListView.builder(
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: 2,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index){
                                          return Padding(
                                            padding: EdgeInsets.all(width*0.025),
                                            child: Container(
                                              width: width*0.8,
                                              height: width*0.45,
                                              decoration: BoxDecoration(
                                                  color: Colors.grey[200],
                                                borderRadius: BorderRadius.circular(width*0.08),
                                              ),
                                            ),
                                          );
                                    }),
                                  ),
                                ),
                              );
                            }else{
                              if(listOfUserRecipesInWidgets.isEmpty){
                                return Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage("assets/images/bee.png")
                                    )
                                  ),
                                );
                              }else{
                                return ListView.builder(
                                    shrinkWrap: false,
                                    itemCount: listOfUserRecipesInWidgets.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return listOfUserRecipesInWidgets[index];
                                    });
                              }

                            }
                          }
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 8, 0, 8),
                        child: Text(
                          "Recipes from the Chef",
                          style: TextStyle(
                              fontSize: height*0.02,
                              color: Colors.grey,
                              letterSpacing: 2
                          ),
                        ),
                      ),
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                          itemCount: widget.resultsList.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context,index){
                            return Column(
                              children: [
                                SearchCard(widget.resultsList[index], widget.resultsList[index].image,widget.resultsList[index].label, widget.color),
                                Divider(
                                  thickness: 1,
                                  indent: 50,
                                  endIndent: 50,
                                )
                              ],
                            );
                      }
                      )
                        ],)
                      ),
                ],
              )
              ),
          ),
        ),
      ),
    );
  }
}
