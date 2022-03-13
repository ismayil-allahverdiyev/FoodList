import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:untitled2/datas/details.dart';
import 'package:untitled2/screens/search_results_page.dart';

class LoadingForSearch extends StatefulWidget {

  String? searchKey;
  String? url;
  Color? color;
  LoadingForSearch(this.url, this.color, this.searchKey, {Key? key}) : super(key: key);

  @override
  _LoadingForSearchState createState() => _LoadingForSearchState();
}

class _LoadingForSearchState extends State<LoadingForSearch> {

  List<details> searchResults = [];
  
  getData() async{
    var response = await http.get(Uri.parse(widget.url!));
    Map data = jsonDecode(response.body);
    await data["hits"].forEach((e) {
        details detail = details(
          type: "chef",
          label: e["recipe"]["label"],
          url: e["recipe"]["url"],
          uri: e["recipe"]["uri"],
          image: e["recipe"]["image"],
          cuisine: e["recipe"]["cuisine"],
          source: e["recipe"]["source"],
          dietLabels: e["recipe"]["dietLabels"],
          healthLabels: e["recipe"]["healthLabels"],
          ingredients: e["recipe"]["ingredients"],
          totalTime: e["recipe"]["totalTime"].toInt(),
          calories: e["recipe"]["calories"].toInt(),
          protein: e["recipe"]["totalNutrients"]["PROCNT"]["quantity"].toInt(),
          totalDaily: e["recipe"]["totalDaily"],
          digest: e["recipe"]["digest"],
      );
        searchResults.add(detail);
    }
    );
    Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SearchResults(searchResults, widget.color, widget.searchKey)));
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: widget.color,
        body: const SpinKitWave(
          color: Colors.white,
          size: 70.0,

        ),
      ),
    );
  }
}
