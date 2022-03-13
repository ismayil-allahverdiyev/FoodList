
import 'package:flutter/foundation.dart';

class ValueChanger extends ChangeNotifier{

  int _value = -100;
  int _value2 = -100;

  updateWithTheValue(value){
    _value = value;
    notifyListeners();
  }
  updateWithTheValue2(value){
    _value2 = value;
    notifyListeners();
  }

  int get value => _value;
  int get value2 => _value2;

}
