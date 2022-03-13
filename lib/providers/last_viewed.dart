
import 'package:flutter/cupertino.dart';
import 'package:untitled2/datas/details.dart';

class LastViewed extends ChangeNotifier{

  final List<details> _lastViewedReceipes = [];


  List<details> get lastViewedReceipes => _lastViewedReceipes;

  void addReceipe(details receipe){
    if(_lastViewedReceipes.contains(receipe)){
      _lastViewedReceipes.remove(receipe);
      _lastViewedReceipes.add(receipe);
      notifyListeners();
    } else if(_lastViewedReceipes.length<5){
      _lastViewedReceipes.add(receipe);
      notifyListeners();
    } else if(_lastViewedReceipes.length == 5){
      _lastViewedReceipes.removeAt(0);
      _lastViewedReceipes.add(receipe);
      notifyListeners();
    }
  }

  void printReceipes(){
    for(int i = 0; i<_lastViewedReceipes.length; i++){
    }
  }
}