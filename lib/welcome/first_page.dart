import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled2/datas/database_helper.dart';
import 'package:untitled2/providers/page_controller.dart';


class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> with TickerProviderStateMixin{

  AnimationController? greenController;

  Animation? greenSizeAnimation;

  AnimationController? purpleController;

  Animation? purpleSizeAnimation;

  AnimationController? orangeController;

  Animation? orangeSizeAnimation;

  AnimationController? blueController;

  Animation? blueSizeAnimation;
  
  double green = 50;

  double orange = 10;

  double blue = 200;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    greenController = AnimationController(
        duration: Duration(milliseconds: 1000),
        vsync: this
    );

    greenSizeAnimation = TweenSequence(
        <TweenSequenceItem<double>>[
          TweenSequenceItem<double>(
              tween: Tween(begin: 50, end: 150),
              weight: 70
          ),
          TweenSequenceItem<double>(
              tween: Tween(begin: 150, end: 120),
              weight: 30
          ),

        ]
    ).animate(greenController!);

    purpleController = AnimationController(
        duration: Duration(milliseconds: 2000),
        vsync: this

    );

    purpleSizeAnimation = TweenSequence(
        <TweenSequenceItem<double>>[
          TweenSequenceItem<double>(
              tween: Tween(begin: 300, end: 720),
              weight: 30
          ),
          TweenSequenceItem<double>(
            tween: Tween(begin: 720, end: 500),
            weight: 23,
          ),
          TweenSequenceItem<double>(
            tween: Tween(begin: 500, end: 620),
            weight: 24,
          ),
          TweenSequenceItem<double>(
            tween: Tween(begin: 620, end: 480),
            weight: 23,
          ),

        ]
    ).animate(purpleController!);

    orangeController = AnimationController(
        duration: Duration(milliseconds: 1200),
        vsync: this
    );

    orangeSizeAnimation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
            tween: Tween(begin: 24, end: 72),
            weight: 60
        ),
        TweenSequenceItem<double>(
            tween: Tween(begin: 72, end: 48),
            weight: 40
        ),

      ]
    ).animate(orangeController!);

    blueController = AnimationController(
        duration: Duration(milliseconds: 2300),
        vsync: this
    );

    blueSizeAnimation = TweenSequence(
        <TweenSequenceItem<double>>[
          TweenSequenceItem<double>(
              tween: Tween(begin: 300, end: 650),
              weight: 40
          ),
          TweenSequenceItem<double>(
            tween: Tween(begin: 650, end: 500),
            weight: 20,
          ),
          TweenSequenceItem<double>(
            tween: Tween(begin: 500, end: 620),
            weight: 20,
          ),
          TweenSequenceItem<double>(
            tween: Tween(begin: 620, end: 480),
            weight: 20,
          ),

        ]
    ).animate(blueController!);

    purpleController!.forward();
    greenController!.forward();
    orangeController!.forward();
    blueController!.forward();
  }


  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.width);
    return MediaQuery(
      data: MediaQueryData(),
      child: Scaffold(
        backgroundColor: Color.fromRGBO(216, 221, 249, 1),
        body: Stack(
          children: [
            Positioned(
              top: -MediaQuery.of(context).size.height/4,
                right: -MediaQuery.of(context).size.width/4,
                child:  AnimatedBuilder(
                  animation: purpleController!,
                  builder: (BuildContext context, _) {
                    double value = purpleSizeAnimation!.value;
                    return Container(
                      height: purpleSizeAnimation!.value,
                      width: purpleSizeAnimation!.value,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10000),
                        color: Color.fromRGBO(119, 118, 188, 1),
                      ),
                    );
                  }
                )
            ),
            Center(
                child: Text("Hello\n      Chef!", style: TextStyle(fontFamily: "Qwitcher", fontSize: 100),)
            ),
            Positioned(
              top: MediaQuery.of(context).size.width,
              left: -MediaQuery.of(context).size.width/8,
              child: AnimatedBuilder(
                animation: greenController!,
                builder: (BuildContext context, _) {
                  double value = greenSizeAnimation!.value;
                  return Container(
                    height: value,
                    width: value,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1000),
                      color: Colors.greenAccent,
                    ),
                  );
                }
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.width*1.3,
              left: MediaQuery.of(context).size.width*0.15,
              child: AnimatedBuilder(
                animation: orangeController!,
                builder: (BuildContext context, _) {
                  double value = orangeSizeAnimation!.value;
                  return Container(
                    height: orangeSizeAnimation!.value,
                    width: orangeSizeAnimation!.value,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10000),
                      color: Color.fromRGBO(246, 138, 95, 1),
                    ),
                  );
                }
              )
            ),
            Positioned(
              bottom: -MediaQuery.of(context).size.width/2,
              left: -MediaQuery.of(context).size.width/1.6,
              child: AnimatedBuilder(
                animation: blueController!,
                builder: (BuildContext context, _) {
                  double value = blueSizeAnimation!.value;
                  return Container(
                    height: blueSizeAnimation!.value,
                    width: blueSizeAnimation!.value,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10000),
                      color: Color.fromRGBO(130, 220, 229, 1),
                    ),
                  );
                }
              )
            ),
            Positioned(
              bottom: 40,
              right: 40,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 100),
                height: 50,
                width: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.blue,
                ),
                child: Consumer<PageControl>(
                    builder: (_, pageController, child) => TextButton(
                    onPressed: ()async{
                      pageController.changePage();
                    },
                    child: Text("Next", style: TextStyle(color: Colors.white),),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
