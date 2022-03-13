import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled2/providers/page_controller.dart';
import 'package:untitled2/providers/value_changer.dart';
import 'package:untitled2/welcome/first_page.dart';
import 'package:untitled2/welcome/second_page.dart';
import 'package:untitled2/welcome/third_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  Widget build(BuildContext context) {

    SystemChrome.setEnabledSystemUIOverlays([]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ValueChanger(),),
        ChangeNotifierProvider(create: (_) => PageControl(),),
      ],
      child: MaterialApp(
        home: Scaffold(
          body: DefaultTabController(
            length: 3,
            child: Stack(
              children: [
                Consumer<PageControl>(
                  builder: (_, pageController, child) => PageView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: pageController.control,
                    children: [
                      FirstPage(),
                      SecondPage(),
                      ThirdPage(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 80),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Consumer<PageControl>(
                        builder: (_, pageController, child) => SmoothPageIndicator(
                          controller: pageController.control,
                          count: 3
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
