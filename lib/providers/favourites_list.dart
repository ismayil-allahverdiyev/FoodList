import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/datas/details.dart';

class Favourite with ChangeNotifier{

  List<details> _favourites = [];
  List<dynamic>? favouritesFromFB;

  Future<List<details>> takeFirebaseFavs()async{
    print('I worked');
    _favourites = [];
    await FirebaseFirestore.instance.collection("users").
    doc(FirebaseAuth.instance.currentUser!.uid).
    get().then(
            (value) {
              favouritesFromFB = value.get("favorites");
              print("I am from await");
        }
    );
    print(favouritesFromFB);
    favouritesFromFB!.forEach((element) {
      print("${element["source"]}***");
      _favourites.add(details(
        type: element["type"],
        uri: element["uri"],
        url: element["url"],
        calories: element["calories"],
        totalTime: element["totalTime"],
        healthLabels: [],
        source: element["source"],
        cuisine: element["cuisine"],
        dietLabels: element["dietLabels"],
        ingredients: element["ingredients"],
        protein: element["protein"],
        largeImage: element["largeImage"],
        mediumImage: element["mediumImage"],
        image: element["image"],
        label: element["label"],
        totalDaily: element["totalDaily"],
        digest: element["digest"],
      ));
    });
    notifyListeners();
    return _favourites;
  }

  List<details> getFavList(){
    return _favourites;
  }

  String? _name;
  String? _email;
  String? _uid;
  String? _imageUrl;
  String? _joinedAt;
  String? _displayName;

  void addFavourites(details newFavourites)async{
    _favourites.add(newFavourites);
    List<Map> favourites = [];
    favouritesFromFB = [];
    _favourites.forEach((element) {
      print(element.largeImage);
      favouritesFromFB!.add({
        "totalDaily": element.totalDaily,
        "digest": element.digest,
        "type":element.type,
        "uri": element.uri,
        "description": element.description,
        "url": element.url,
        "calories": element.calories,
        "totalTime": element.totalTime,
        "healthLabels": element.totalTime,
        "source": element.source,
        "cuisine": element.cuisine,
        "dietLabels": element.dietLabels,
        "ingredients": element.ingredients,
        "protein": element.protein,
        "largeImage": element.largeImage,
        "mediumImage": element.mediumImage,
        "image": element.image,
        "label": element.label,
      });
    });
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
    _uid = userDoc.get("id");
    _name = userDoc.get("name");
    _email = userDoc.get("email");
    _imageUrl = userDoc.get("imageUrl");
    _joinedAt = userDoc.get("joinedAt");
    _displayName = '';
    await FirebaseFirestore.instance.collection("users").
    doc(FirebaseAuth.instance.currentUser!.uid).
    set({
      'id': _uid,
      'name': _name,
      'email': _email,
      'imageUrl': _imageUrl,
      'joinedAt': _joinedAt,
      'displayName': _displayName,
      "favorites": favouritesFromFB
    });
    notifyListeners();
  }

  void deleteFavourites(details newFavourites)async{
    print("remove called");
    _favourites.remove(newFavourites);
    List<Map> favourites = [];
    favouritesFromFB = [];
    _favourites.forEach((element) {
      print(element.largeImage);
      favouritesFromFB!.add({
        "totalDaily": element.totalDaily,
        "digest": element.digest,
        "type": element.type,
        "description": element.description,
        "uri": element.uri,
        "url": element.url,
        "calories": element.calories,
        "totalTime": element.totalTime,
        "healthLabels": element.totalTime,
        "source": element.source,
        "cuisine": element.cuisine,
        "dietLabels": element.dietLabels,
        "ingredients": element.ingredients,
        "protein": element.protein,
        "largeImage": element.largeImage,
        "mediumImage": element.mediumImage,
        "image": element.image,
        "label": element.label,
      });
    });
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).get();
    _uid = userDoc.get("id");
    _name = userDoc.get("name");
    _email = userDoc.get("email");
    _imageUrl = userDoc.get("imageUrl");
    _joinedAt = userDoc.get("joinedAt");
    _displayName = '';
    await FirebaseFirestore.instance.collection("users").
    doc(FirebaseAuth.instance.currentUser!.uid).
    set({
      'id': _uid,
      'name': _name,
      'email': _email,
      'imageUrl': _imageUrl,
      'joinedAt': _joinedAt,
      'displayName': _displayName,
      "favorites": favouritesFromFB
    });
    notifyListeners();
  }
}