import 'dart:math';

import 'package:untitled2/datas/database_helper.dart';
import 'package:untitled2/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/datas/details.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoadingPage(),
    );
  }
}

class LoadingPage extends StatefulWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {

  Random random = new Random();

  String link1 = "https://api.edamam.com/search?q=American&app_id=efc2eac7&app_key=85cbbe554ef1744a97197b77b18ee242&from=1&to=20&calories=591-722&health=alcohol-free";
  String link2 = "https://api.edamam.com/search?q=&app_id=efc2eac7&app_key=85cbbe554ef1744a97197b77b18ee242&from=1&to=20&calories=591-722&health=alcohol-free";


  String? choice1;
  String? choice2;
  List<details> allreceipes = [];
  List<details> favreceipes = [];
  String? url1;
  String meat = "https://api.edamam.com/search?q=meat&app_id=efc2eac7&app_key=85cbbe554ef1744a97197b77b18ee242&from=1&to=10&calories=591-722&health=alcohol-free";
  String cake = "https://api.edamam.com/search?q=cake&app_id=efc2eac7&app_key=85cbbe554ef1744a97197b77b18ee242&from=1&to=10&calories=591-722&health=alcohol-free";
  String? url2;
  String vegetable = "https://api.edamam.com/search?q=cake&app_id=efc2eac7&app_key=85cbbe554ef1744a97197b77b18ee242&from=1&to=10&calories=591-722&health=alcohol-free";
  String candy = "https://api.edamam.com/search?q=candy&app_id=efc2eac7&app_key=85cbbe554ef1744a97197b77b18ee242&from=1&to=10&calories=591-722&health=alcohol-free";
  getDbInfo()async{
    Random random = new Random();
    int randomNumber1 = random.nextInt(10);
    while(randomNumber1 == 0){
      randomNumber1 = random.nextInt(10);
    }

    int randomNumber2 = random.nextInt(10);
    while(randomNumber2 == 0){
      randomNumber2 = random.nextInt(10);
    }

    int randomNumber3 = random.nextInt(10);
    while(randomNumber3 == 0){
      randomNumber3 = random.nextInt(10);
    }

    int randomNumber4 = random.nextInt(10);
    while(randomNumber4 == 0){
      randomNumber4 = random.nextInt(10);
    }


    List<Map<String, dynamic>> list = await DatabaseHelper.instance.queryAll();
    choice1 = list[0]['Name'];
    choice2 = list[1]['Name'];
    if(list[0]['Name'] == "2"){
      url1 = "https://api.edamam.com/search?q=meat&app_id=efc2eac7&app_key=85cbbe554ef1744a97197b77b18ee242&from=${randomNumber1*10}&to=${randomNumber1*10 + 20}&calories=591-722&health=alcohol-free";
    }if(list[0]['Name'] == "1"){
      url1 = "https://api.edamam.com/search?q=vegetable&app_id=efc2eac7&app_key=85cbbe554ef1744a97197b77b18ee242&from=${randomNumber2*10}&to=${randomNumber2*10 + 20}&calories=591-722&health=alcohol-free";
    }if(list[1]['Name'] == "1"){
      url2 = "https://api.edamam.com/search?q=cake&app_id=efc2eac7&app_key=85cbbe554ef1744a97197b77b18ee242&from=${randomNumber3*10}&to=${randomNumber3*10 + 20}&calories=591-722&health=alcohol-free";
    }if(list[1]['Name'] == "2"){
      url2 = "https://api.edamam.com/search?q=candy&app_id=efc2eac7&app_key=85cbbe554ef1744a97197b77b18ee242&from=${randomNumber4*10}&to=${randomNumber4*10 + 20}&calories=591-722&health=alcohol-free";
    }
  }

  getApiData() async{
    await Future.delayed(const Duration(seconds: 2), (){});
    if(choice1 == "1" || choice1 =="2") {
      var response = await http.get(Uri.parse(url1!));
      Map json = jsonDecode(response.body);
      await json["hits"].forEach((e) {
        details detail = details(
          type: "chef",
          uri: e["recipe"]["uri"],
          label: e["recipe"]["label"],
          url: e["recipe"]["url"],
          image: e["recipe"]["image"],
          cuisine: e["recipe"]["cuisineType"],
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
        setState(() {
          allreceipes.add(detail);
        });
      }
      );
    }
    if(choice2 == "1" || choice2 =="2") {
      var response2 = await http.get(Uri.parse(url2!));
      Map json2 = jsonDecode(response2.body);
      await json2["hits"].forEach((e) {
        details detail = details(
          type: "chef",
          uri: e["recipe"]["uri"],
          label: e["recipe"]["label"],
          url: e["recipe"]["url"],
          image: e["recipe"]["image"],
          cuisine: e["recipe"]["cuisineType"],
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
        setState(() {
          allreceipes.add(detail);
        }
        );
      }
      );
    }
    if(choice1 == "3") {
      var response2 = await http.get(Uri.parse(meat));
      Map json2 = jsonDecode(response2.body);
      await json2["hits"].forEach((e) {
        details detail = details(
          type: "chef",
          uri: e["recipe"]["uri"],
          label: e["recipe"]["label"],
          url: e["recipe"]["url"],
          image: e["recipe"]["image"],
          cuisine: e["recipe"]["cuisineType"],
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
        setState(() {
          allreceipes.add(detail);
        }
        );
      }
      );
      var response1 = await http.get(Uri.parse(vegetable));
      Map json1 = jsonDecode(response1.body);
      await json1["hits"].forEach((e) {
        details detail = details(
          type: "chef",
          uri: e["recipe"]["uri"],
          label: e["recipe"]["label"],
          url: e["recipe"]["url"],
          image: e["recipe"]["image"],
          cuisine: e["recipe"]["cuisineType"],
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
        setState(() {
          allreceipes.add(detail);

        }
        );
      }
      );
    }
    if(choice2 == "3") {
      var response2 = await http.get(Uri.parse(cake));
      Map json2 = jsonDecode(response2.body);
      await json2["hits"].forEach((e) {
        details detail = details(
          type: "chef",
          uri: e["recipe"]["uri"],
          label: e["recipe"]["label"],
          url: e["recipe"]["url"],
          image: e["recipe"]["image"],
          cuisine: e["recipe"]["cuisineType"],
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
        setState(() {
          allreceipes.add(detail);
        }
        );
      }
      );
      var response1 = await http.get(Uri.parse(candy));
      Map json1 = jsonDecode(response1.body);
      await json1["hits"].forEach((e) {
        details detail = details(
          type: "chef",
          uri: e["recipe"]["uri"],
          label: e["recipe"]["label"],
          url: e["recipe"]["url"],
          image: e["recipe"]["image"],
          cuisine: e["recipe"]["cuisineType"],
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
        setState(() {
          allreceipes.add(detail);
        }
        );
      }
      );
    }
    if(choice1 == "4" || choice1 == "-100") {
      var response2 = await http.get(Uri.parse(link1));
      Map json2 = jsonDecode(response2.body);
      await json2["hits"].forEach((e) {
        details detail = details(
          type: "chef",
          uri: e["recipe"]["uri"],
          label: e["recipe"]["label"],
          url: e["recipe"]["url"],
          image: e["recipe"]["image"],
          cuisine: e["recipe"]["cuisineType"],
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
        setState(() {
          allreceipes.add(detail);
        }
        );
      }
      );
    }
    if(choice2 == "4"|| choice2 == "-100") {
      var response2 = await http.get(Uri.parse(link2));
      Map json2 = jsonDecode(response2.body);
      await json2["hits"].forEach((e) {
        details detail = details(
          type: "chef",
          uri: e["recipe"]["uri"],
          label: e["recipe"]["label"],
          url: e["recipe"]["url"],
          image: e["recipe"]["image"],
          cuisine: e["recipe"]["cuisineType"],
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
        setState(() {
          allreceipes.add(detail);
        }
        );
      }
      );
    }

    Navigator.push((context), MaterialPageRoute(
        builder: (context) =>  Home(allreceipes, favreceipes)
    )
    );
  }

  final Connectivity _connectivity = Connectivity();
  
  String internet = "Checking for internet";

  checkingForInternet()async{
    ConnectivityResult connectivityResult = await _connectivity.checkConnectivity();

    await Future.delayed(Duration(milliseconds: 700), (){});
    setState(() {
      if(connectivityResult != ConnectivityResult.none) {
        internet = "Connected to ${connectivityResult.toString().substring(19)}";
      }else{
        internet = "No connection!";
      }
    });
    await Future.delayed(Duration(milliseconds: 1300), (){});
    setState(() {
      internet = "Loading.";
    });
    await Future.delayed(Duration(milliseconds: 500), (){});
    setState(() {
      internet = "Loading..";
    });
    await Future.delayed(Duration(milliseconds: 500), (){});
    setState(() {
      internet = "Loading...";
    });
    await Future.delayed(Duration(milliseconds: 500), (){});
    setState(() {
      internet = "Loading.";
    });
    await Future.delayed(Duration(milliseconds: 500), (){});
    setState(() {
      internet = "Loading..";
    });
    await Future.delayed(Duration(milliseconds: 500), (){});
    setState(() {
      internet = "Loading...";
    });
    await Future.delayed(Duration(milliseconds: 500), (){});
    setState(() {
      internet = "Loading.";
    });
    await Future.delayed(Duration(milliseconds: 500), (){});
    setState(() {
      internet = "Loading..";
    });
    await Future.delayed(Duration(milliseconds: 500), (){});
    setState(() {
      internet = "Loading...";
    });
    await Future.delayed(Duration(milliseconds: 500), (){});
    setState(() {
      internet = "Loading.";
    });
    await Future.delayed(Duration(milliseconds: 500), (){});
    setState(() {
      internet = "Loading..";
    });
    await Future.delayed(Duration(milliseconds: 500), (){});
    setState(() {
      internet = "Loading...";
    });
  }

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    getDbInfo();
    getApiData();
    checkingForInternet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(119, 118, 188, 1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SpinKitFadingCube(
              color: Colors.white,
              size: 70.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 15),
            child: Text(internet, style: TextStyle(color: Colors.white, fontSize: 25),),
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: Container(
              height: 5,
                width: 100,
                child: LinearProgressIndicator(color: Colors.grey, backgroundColor: Colors.white,)
            ),
          ),
        ],
      ),
    );
  }
}
