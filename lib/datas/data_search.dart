import 'package:flutter/material.dart';
import 'package:untitled2/loading/loading_for_search.dart';
import 'package:untitled2/screens/search_results_page.dart';

class DataSearch extends SearchDelegate<String>{

  String dietType = "";
  String healthType = "";
  String cuisineType = "";

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
    "choose",
    "Alcohol-cocktail",
    "Alcohol-free",
    "Celery-free",
    "Crustacean-free",
    "Dairy-free",
    "DASH",
    "Egg-free	",
    "Fish-free",
    "Fodmap-free",
    "Gluten-free",
    "Immuno-supportive",
    "Keto-friendly",
    "Kidney-friendly",
    "Kosher",
    "Low-potassium",
    "Low-sugar",
    "Lupine-free",
    "Mediterranean",
    "Mollusk-free",
    "Mustard-free",
    "No-oil-added",
    "Paleo",
    "Peanut-free",
    "Pecatarian",
    "Pork-free",
    "Red-meat-free",
    "Sesame-free",
    "Shellfish-free",
    "Soy-free",
    "Sugar-conscious",
    "Sulfite-free",
    "Tree-nut-free",
    "Vegan",
    "Vegetarian",
    "Wheat-free	"
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

  final recentSearches = [
    "meat",
    "chicken",
    "sugar",
    "pepper",
    "soup",
    "fish",
    "beaf",
    "pork"
  ];
  @override
  List<Widget>? buildActions(BuildContext context) {
    //actions for app bar
    return [
      IconButton(onPressed: (){
        query = "";
      }, icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // leading icon of search bar
    return IconButton(
        onPressed: (){
          close(context, "");
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        )
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    String url = "https://api.edamam.com/search?q=$query&app_id=efc2eac7&app_key=85cbbe554ef1744a97197b77b18ee242&from=1&to=101&calories=591-722&health=alcohol-free";
    return Navigator(onGenerateRoute: (RouteSettings settings) {
      return MaterialPageRoute(builder: (context) => LoadingForSearch(url, Color.fromRGBO(119, 118, 188, 1), query)

      );
    }
    );
    throw UnimplementedError(url);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // show when someone searches for something
    String hint1 = "choice";
    String hint2 = "choice";
    String hint3 = "choice";
    final suggestionList = query.isEmpty ? recentSearches : recentSearches.where((element) => element.startsWith(query)).toList();
    return Scaffold(
      resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Stack(
            fit: StackFit.loose,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 5, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        color: Colors.grey.withOpacity(0.4),

                      ),
                      width: 400,
                      height: 200,
                      child: ListView.builder(itemBuilder: (context, index) => ListTile(
                        leading: const Icon(Icons.search),
                        title: RichText(
                            text: TextSpan(text: suggestionList[index].substring(0, query.length),
                                style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                  color: Colors.black
                            ),
                              children: [
                                TextSpan(
                                    text: suggestionList[index].substring(query.length),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.normal
                                  )
                                )
                              ]
                            ),

                        ),
                      ),
                          itemCount: suggestionList.length
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                          child: Container(
                            width: 100,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                topLeft: Radius.circular(10),
                              ),
                            ),
                            child: const Center(
                                child: Text("Diet type")
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                          child: Container(
                              width: 200,
                              height: 40,
                              color: const Color.fromRGBO(225, 216, 159, 1),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(54,0,0,0),
                                child: DropdownButton<String>(
                                  items: dietList.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),

                                  onChanged: (_) {},
                                ),
                              )
                          ),
                        )
                      ],
                    ),
                  ),
                  Center(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                          child: Container(
                            width: 100,
                            height: 40,
                            decoration: const BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                topLeft: Radius.circular(10),
                              ),
                            ),
                            child: const Center(
                                child: Text("Health type")
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                          child: Container(
                              width: 200,
                              height: 40,
                              color: const Color.fromRGBO(225, 216, 159, 1),
                              child: DropdownButton<String>(
                                hint: Text(hint2),
                                items: healthLabelsList.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (_){},
                              )
                          ),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 0, 0),
                        child: Container(
                          width: 100,
                          height: 40,
                          decoration: const BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              topLeft: Radius.circular(10),
                            ),
                          ),
                          child: const Center(
                              child: Text("Cuisine type")
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
                        child: Container(
                            width: 200,
                            height: 40,
                            color: const Color.fromRGBO(225, 216, 159, 1),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(18,0,0,0),
                              child: DropdownButton<String>(
                                items: cuisineTypeList.map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged:(_){},
                              ),
                            )
                        ),
                      )
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
        );
  }

}