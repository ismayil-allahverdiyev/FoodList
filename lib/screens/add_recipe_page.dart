import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({Key? key}) : super(key: key);

  @override
  _AddRecipePageState createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {

  String cuisineType = "other";

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


  TextEditingController ingredientController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController proteinController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController caloriesController = TextEditingController();
  List<String> ingredientNames = [];
  List<ListTile> listOfIngredients = [];
  String _imageUrl = '';
  String _ingredientImage = '';
  List<Map> IngredientMap = [];
  ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    int num = 1;

    print("State build");
    print(listOfIngredients);
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if(currentFocus.hasPrimaryFocus!=true){
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Color.fromRGBO(230, 250, 250, 1),
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(230, 250, 255, 0.7),
          elevation: 0,
          leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back, color: Colors.black,)
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: GestureDetector(
                  onTap: ()async{
                    List<dynamic> listForDescriptions = [];
                    await FirebaseFirestore.instance.collection("userRecipes").doc("recipes").get().then(
                            (value) => listForDescriptions = value.get("descriptions")
                    );
                    return await showDialog(
                        context: context,
                        builder: (BuildContext context) => SimpleDialog(
                          title: Text("Change profile picture"),
                          children: [
                            SimpleDialogOption(
                              onPressed: ()async{
                                Navigator.pop(context);
                                final pickedFile = await _picker.pickImage(
                                    source: ImageSource.camera,
                                    imageQuality: 100
                                );
                                File file = File(pickedFile!.path);
                                final ref = FirebaseStorage.instance
                                    .ref()
                                    .child("RecipeImages")
                                    .child("${listForDescriptions.length}");
                                await ref.putFile(file);
                                String link = await ref.getDownloadURL();
                                setState(() {
                                  _imageUrl = link;
                                });
                                print(_imageUrl);
                              },
                              child: ListTile(
                                leading: Icon(Icons.camera_alt_outlined, size: 30,),
                                title: Text("From Camera", style: TextStyle(fontSize: 20),),
                              ),
                            ),
                            SimpleDialogOption(
                              onPressed: ()async{
                                Navigator.pop(context);
                                final pickedFile = await _picker.pickImage(
                                    source: ImageSource.gallery,
                                    imageQuality: 100
                                );
                                File file = File(pickedFile!.path);
                                final ref = FirebaseStorage.instance
                                    .ref()
                                    .child("RecipeImages")
                                    .child("${listForDescriptions.length}");
                                await ref.putFile(file);
                                String link = await ref.getDownloadURL();
                                setState(() {
                                  _imageUrl = link;
                                });
                                print(_imageUrl);
                              },
                              child: ListTile(
                                leading: Icon(CupertinoIcons.photo, size: 30,),
                                title: Text("From Galery", style: TextStyle(fontSize: 20),),
                              ),
                            ),
                          ],
                        )
                    );
                  },
                  child:_imageUrl=="" ? Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(245, 245, 240, 1),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 1.5)
                    ),
                    height: width*0.45,
                    width: width*0.90,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.add_a_photo_outlined,size: 35,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Choose",
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w500,
                                fontSize: width*0.037,
                                letterSpacing: 2
                            ),
                          ),
                        )
                      ],
                    ),
                  ) : Container(
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(245, 245, 240, 1),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 1.5),
                      image: DecorationImage(
                        image: NetworkImage(_imageUrl),
                        fit: BoxFit.cover
                      )
                    ),
                    height: width*0.45,
                    width: width*0.90,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Center(
                        child: Icon(Icons.title, color: Colors.cyan, size: 30,)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      width: width*0.7,
                      child: TextField(
                        controller: titleController,
                        maxLength: 40,
                        decoration: InputDecoration(
                          labelText: "Title",
                          labelStyle: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w500,
                              fontSize: MediaQuery.of(context).size.height*0.02,
                              letterSpacing: 2
                          ),
                          hintStyle: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w500,
                              fontSize: MediaQuery.of(context).size.height*0.02,
                              letterSpacing: 2
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Center(
                        child: Icon(Icons.description, color: Colors.cyan, size: 30,)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      width: width*0.7,
                      child: TextField(
                        controller: descriptionController,
                        maxLength: 100,
                        decoration: InputDecoration(
                          labelText: "Description",
                          labelStyle: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w500,
                              fontSize: MediaQuery.of(context).size.height*0.02,
                              letterSpacing: 2
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.fromLTRB(8, 15, 8, 0),
                    child: Center(
                        child: Icon(Icons.place, color: Colors.cyan, size: 30,)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: DropdownButton<String>(
                        icon: const Icon(Icons.arrow_downward),
                        hint: Text(
                          cuisineType,
                          style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w500,
                              fontSize: MediaQuery.of(context).size.height*0.02,
                              letterSpacing: 2
                          ),
                        ),
                        elevation: 16,
                        style: const TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            cuisineType = newValue!;
                          });
                          print(cuisineType);
                        },
                        items: cuisineTypeList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      )
                    ),
                  )
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 15, 8, 0),
                    child: Center(
                        child: Icon(Icons.accessibility, color: Colors.cyan, size: 30,)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      width: width*0.4,
                      child: TextField(
                        controller: proteinController,
                        decoration: InputDecoration(
                          labelText: "Protein amount",
                          labelStyle: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w500,
                              fontSize: MediaQuery.of(context).size.height*0.02,
                              letterSpacing: 2
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 15, 8, 0),
                    child: Center(
                        child: Icon(Icons.timer, color: Colors.cyan, size: 30,)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      width: width*0.3,
                      child: TextField(
                        controller: timeController,
                        decoration: InputDecoration(
                          labelText: "Time (min)",
                          labelStyle: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w500,
                              fontSize: MediaQuery.of(context).size.height*0.02,
                              letterSpacing: 2
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 15, 8, 0),
                    child: Center(
                        child: Icon(Icons.directions_run, color: Colors.cyan, size: 30,)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      width: width*0.4,
                      child: TextField(
                        controller: caloriesController,
                        decoration: InputDecoration(
                          labelText: "Calories (kCal)",
                          labelStyle: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w500,
                              fontSize: MediaQuery.of(context).size.height*0.02,
                              letterSpacing: 2
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(80, 8, 8, 8),
                  child: Text(
                    "Ingredients",
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w500,
                        fontSize: MediaQuery.of(context).size.height*0.02,
                      letterSpacing: 2
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(245, 245, 240, 1),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                    border: Border.all(color: Colors.grey, style: BorderStyle.solid, width: 1.5)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: ()async{
                        List<dynamic> listForDescriptions = [];
                        await FirebaseFirestore.instance.collection("userRecipes").doc("recipes").get().then(
                                (value) => listForDescriptions = value.get("descriptions")
                        );
                        return await showDialog(
                            context: context,
                            builder: (BuildContext context) => SimpleDialog(
                              title: Text("Change profile picture"),
                              children: [
                                SimpleDialogOption(
                                  onPressed: ()async{
                                    Navigator.pop(context);
                                    final pickedFile = await _picker.pickImage(
                                        source: ImageSource.camera,
                                        imageQuality: 100
                                    );
                                    File file = File(pickedFile!.path);
                                    print(ingredientNames.length);
                                    final ref = FirebaseStorage.instance
                                        .ref()
                                        .child("IngredientsPictures")
                                        .child("${listForDescriptions.length}${ingredientNames.length}");
                                    await ref.putFile(file);
                                    String link = await ref.getDownloadURL();
                                    setState(() {
                                      _ingredientImage = link;
                                    });
                                    print(_ingredientImage);
                                  },
                                  child: ListTile(
                                    leading: Icon(Icons.camera_alt_outlined, size: 30,),
                                    title: Text("From Camera", style: TextStyle(fontSize: 20),),
                                  ),
                                ),
                                SimpleDialogOption(
                                  onPressed: ()async{
                                    Navigator.pop(context);
                                    final pickedFile = await _picker.pickImage(
                                        source: ImageSource.gallery,
                                        imageQuality: 100
                                    );
                                    File file = File(pickedFile!.path);
                                    List<dynamic> listForDescriptions = [];
                                    await FirebaseFirestore.instance.collection("userRecipes").doc("recipes").get().then(
                                            (value) => listForDescriptions = value.get("descriptions")
                                    ).then((value) async{
                                      final ref = FirebaseStorage.instance
                                          .ref()
                                          .child("IngredientsPictures")
                                          .child("${listForDescriptions.length}${listOfIngredients.length+1}");
                                      await ref.putFile(file);
                                      String link = await ref.getDownloadURL();
                                      setState(() {
                                        _ingredientImage = link;
                                      });
                                      print(_ingredientImage);
                                      }
                                    );
                                  },
                                  child: ListTile(
                                    leading: Icon(CupertinoIcons.photo, size: 30,),
                                    title: Text("From Galery", style: TextStyle(fontSize: 20),),
                                  ),
                                ),
                              ],
                            )
                        );
                      },
                      child: _ingredientImage != ""?Container(
                        width: width*0.1,
                        height: width*0.1,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            border: Border.all(color: Colors.black, width: 1, style: BorderStyle.solid),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          image: DecorationImage(
                            image: NetworkImage(_ingredientImage),
                            fit: BoxFit.cover
                          )
                        ),
                      ):Container(
                        width: width*0.1,
                        height: width*0.1,
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            border: Border.all(color: Colors.black, width: 1, style: BorderStyle.solid),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Center(
                          child: Icon(Icons.camera_alt_outlined),
                        ),
                      ),
                    ),
                    Container(
                      width: width*0.6,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(40.0, 10, 0, 10),
                        child: TextFormField(
                          controller: ingredientController,
                          decoration: InputDecoration(
                            hintText: "Ingredient name...",
                            hintStyle: TextStyle(
                                color: Colors.grey[800],
                                fontWeight: FontWeight.w500,
                                fontSize: MediaQuery.of(context).size.height*0.02,
                                letterSpacing: 2
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: width*0.1,),
                    IconButton(
                        onPressed: (){
                          if(ingredientController.text.isNotEmpty) {
                            ingredientNames.add(ingredientController.text);
                            listOfIngredients.add(
                              ListTile(
                                leading: Container(
                                  width: width*0.1,
                                  height: width*0.1,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(_ingredientImage)
                                    )
                                  ),
                                ),
                                title: Text(
                                  "${ingredientController.text}",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: width*0.03,
                                      letterSpacing: 2
                                  ),
                                ),
                              )
                          );
                          }
                          setState(() {
                            listOfIngredients = listOfIngredients;
                            IngredientMap.add({"text": ingredientController.text, "image": _ingredientImage});
                            _ingredientImage = "";
                          });
                        },
                        icon: Icon(Icons.add)
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: listOfIngredients,
            ),
            GestureDetector(
              onTap: ()async{
                if(timeController.text.isNotEmpty &&
                    titleController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty &&
                    proteinController.text.isNotEmpty &&
                    caloriesController.text.isNotEmpty &&
                    listOfIngredients.isNotEmpty){
                  List<dynamic> list = [];
                  List<dynamic> listForDescriptions = [];
                  await FirebaseFirestore.instance.collection("userRecipes").doc("recipes").get().then(
                      (value) => listForDescriptions = value.get("descriptions")
                  );
                  await FirebaseFirestore.instance.collection("userRecipes").doc("recipes").get().then(
                          (value) => list = value.get("recipe")
                  ).then(
                          (value) {
                            list.add({
                              "type": "user",
                              "uri": list.length+1,
                              "id": FirebaseAuth.instance.currentUser!.uid,
                              "label": titleController.text,
                              "description": descriptionController.text,
                              "totalTime": timeController.text,
                              "protein": proteinController.text,
                              "calories": caloriesController.text,
                              "ingredients": IngredientMap,
                              "image": _imageUrl,
                              "url": "",
                              "source": "",
                              "mediumImage": "",
                              "largeImage": "",
                              "dietLabels": [],
                              "healthLabels": [],
                              "cuisine": [cuisineType],
                              "totalDaily": {},
                              "digest": [],
                            });
                            listForDescriptions.add(descriptionController.text);
                          }).then(
                          (value)async{
                            await FirebaseFirestore.instance.collection("userRecipes").doc("recipes").set({
                              "recipe": list,
                              "descriptions": listForDescriptions
                            });
                          }
                  ).then((value) => Navigator.pop(context));
                }
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: timeController.text.isNotEmpty && titleController.text.isNotEmpty && descriptionController.text.isNotEmpty && proteinController.text.isNotEmpty && caloriesController.text.isNotEmpty && listOfIngredients.isNotEmpty ? Colors.red : Colors.grey,
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      height: MediaQuery.of(context).size.width*0.13,
                      width: MediaQuery.of(context).size.width*0.6,
                      child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FittedBox(
                              child: Text('Add your recipe',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: MediaQuery.of(context).size.height*0.02,
                                  letterSpacing: 2,
                                ),
                              )
                            ),
                          )
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
