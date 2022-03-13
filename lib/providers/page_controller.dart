import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class PageControl extends ChangeNotifier{

  final pageController = PageController(initialPage: 0);

  get control => pageController;

  void changePage(){
    pageController.animateToPage(pageController.page!.round()+1, duration: Duration(milliseconds: 600), curve: Curves.linear);
    notifyListeners();
  }

}