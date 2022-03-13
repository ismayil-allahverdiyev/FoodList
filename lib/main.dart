import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:untitled2/providers/favourites_list.dart';
import 'package:untitled2/providers/last_viewed.dart';
import 'package:untitled2/welcome/welcome_page.dart';
import 'package:untitled2/services/authentication_service.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:untitled2/screens/authentication_wrapper.dart';
import 'datas/database_helper.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  List<Map<String, dynamic>> list = await DatabaseHelper.instance.queryAll();

  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => Favourite()),
          ChangeNotifierProvider(create: (_) => LastViewed()),
          Provider<AuthenticationService>(create: (_) => AuthenticationService(FirebaseAuth.instance),),
          StreamProvider(create: (context) => context.read<AuthenticationService>().authService, initialData: null)
        ],
        child: list.isEmpty ? WelcomePage() : MyApp(),
      )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MediaQuery(
          data: MediaQueryData(),
          child: MaterialApp(
              home: AuthenticationWrapper()
          )
    );
  }
}


class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  int signUpChecker = 1;

  Future notificationSelected(String? payload) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text("Notification : $payload"),
      ),
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var androidInitilize = new AndroidInitializationSettings('ic_launcher');
    var iOSinitilize = new IOSInitializationSettings();
    var initilizationsSettings =
    InitializationSettings(iOS: iOSinitilize,android: androidInitilize);
    var fltrNotification = FlutterLocalNotificationsPlugin();
    fltrNotification.initialize(initilizationsSettings,
        onSelectNotification: notificationSelected
    );
    _showNotification();
  }

  Future _showNotification() async {
    var androidDetails = AndroidNotificationDetails(
        "1 Food", "Foody Bee",
        importance: Importance.max);
    var iSODetails = new IOSNotificationDetails();
    var generalNotificationDetails =
    new NotificationDetails(android: androidDetails, iOS: iSODetails);
    var fltrNotification = FlutterLocalNotificationsPlugin();
    await fltrNotification.periodicallyShow(0, 'Foody bee - Your favorite chef',
        'You might wanna search for new recipes to cook today!!!', RepeatInterval.daily, generalNotificationDetails,
        androidAllowWhileIdle: true);
  }

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    SystemChrome.setEnabledSystemUIOverlays([]);
    String signInWord = "Let's sign in!";
    String signUpWord = "Sign Up!";
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          FocusScope.of(context).requestFocus(FocusNode());
        }
      },
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: ListView(
            // physics: const NeverScrollableScrollPhysics(),
            children: <Widget>[
              Container(
                width: width,
                height: height*0.35,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage("https://cdn.pixabay.com/photo/2020/07/20/07/32/star-anise-5422155__340.jpg"),
                    fit: BoxFit.cover
                  )
                ),
              ),
              Container(
                width: width,
                height: height*0.9,
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(119, 118, 188, 1),
                    borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35)
                  )
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 0.1 * height),
                    Padding(
                      padding: EdgeInsets.fromLTRB(width*0.1, 0, width*0.1, 0),
                      child: Text(
                        signUpChecker == 1 ? signInWord : signUpWord,
                        textAlign: TextAlign.start,
                        style: const TextStyle(
                          fontSize: 35,
                          color: Color.fromRGBO(255, 238, 207, 1)
                        ),
                      ),
                    ),
                    signUpChecker == 2 ? Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        textInputAction: TextInputAction.go,
                        controller: nameController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          fillColor: Colors.grey[200],
                          filled: true,
                          focusColor: Colors.deepOrangeAccent,
                          hintText: 'Your full name',
                        ),
                      ),
                    ) : Container(),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        textInputAction: TextInputAction.go,
                        controller: emailController,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          fillColor: Colors.grey[200],
                          filled: true,
                          focusColor: Colors.deepOrangeAccent,
                          hintText: 'Your e-mail adress',
                        ),
                      ),
                    ),
                    signUpChecker != 3 ? Padding(
                      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: TextField(
                        textInputAction: TextInputAction.go,
                        obscureText: true,
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          fillColor: Colors.grey[200],
                          filled: true,
                          focusColor: Colors.deepOrangeAccent,
                          hintText: 'Password',
                        ),
                      ),
                    ) : Container(),
                    signUpChecker == 1 ? Padding(
                      padding: EdgeInsets.fromLTRB(width*0.1, height*0.02, width*0.1, 0),
                      child: TextButton(
                          onPressed: (){
                            context.read<AuthenticationService>().signIn(
                              email: emailController.text,
                              password: passwordController.text
                            );
                            FocusScopeNode currentFocus = FocusScope.of(context);

                            if (!currentFocus.hasPrimaryFocus) {
                              FocusScope.of(context).requestFocus(FocusNode());
                            }
                            setState(() {
                              emailController.text = "";
                              passwordController.text = "";
                            });
                          },
                          child:
                          Container(
                            width: width*0.8,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(207, 92, 54, 1),
                              borderRadius: BorderRadius.circular(30)
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: width*0.25,),
                                const Icon(Icons.check_rounded),
                                const Text("Start cooking", style: TextStyle(color: Color.fromRGBO(239, 200, 139, 1)),)
                              ],
                            ),
                          )
                      ),
                    )  : Container(),
                    signUpChecker == 1 || signUpChecker == 3 ? Padding(
                      padding: EdgeInsets.fromLTRB(width*0.365, height*0.02, width*0.365, 0),
                      child: TextButton(
                          onPressed: (){
                            signUpChecker == 3 ? context.read<AuthenticationService>().forgetPassword(email: emailController.text) : print("not the right screen");
                            final snackBar = signUpChecker == 3 && emailController.text.contains("@") ? SnackBar(content: Text("E-mail sent!"))  : SnackBar(content: Text("Use correct e-mail"));
                            signUpChecker == 3 ? ScaffoldMessenger.of(context).showSnackBar(snackBar) : print("Some error");
                            FocusScopeNode currentFocus = FocusScope.of(context);

                            if (!currentFocus.hasPrimaryFocus) {
                              FocusScope.of(context).requestFocus(FocusNode());
                            }
                            setState(() {
                              signUpChecker = 3;
                            });
                          },
                          child: Center(
                            child: Text(
                                signUpChecker != 3 ? "Forget password?" : "Send an e-mail!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: signUpChecker != 3 ? const Color.fromRGBO(207, 92, 54, 1) : const Color.fromRGBO(207, 200, 54, 1),
                              ),
                            ),
                          )
                      ),
                    ) : Container(),
                    signUpChecker != 3 ? Padding(
                      padding: EdgeInsets.fromLTRB(width*0.1, height*0.02, width*0.1, 0),
                      child: TextButton(
                          onPressed: (){
                            FocusScopeNode currentFocus = FocusScope.of(context);

                            if (!currentFocus.hasPrimaryFocus) {
                              FocusScope.of(context).requestFocus(FocusNode());
                            }
                          },
                          child: GestureDetector(
                            onTap: (){
                              signUpChecker == 2 ? context.read<AuthenticationService>().signUp(name: nameController.text,email: emailController.text,password: passwordController.text) : print("");
                              setState(() {
                                signUpChecker = 2;
                              });
                            },
                            child: Container(
                              width: width*0.8,
                              height: 50,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(207, 92, 54, 1),
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              child: Row(
                                children: [
                                  SizedBox(width: width*0.35,),
                                  const Text(
                                    "Sign up!",
                                    style: TextStyle(color: Color.fromRGBO(239, 200, 139, 1)),
                                  )
                                ],
                              ),
                            ),
                          )
                      ),
                    ) : Container(),
                    signUpChecker == 2 || signUpChecker == 3 ? Padding(
                      padding: EdgeInsets.fromLTRB(width*0.1, height*0.02, width*0.1, 0),
                      child: TextButton(
                          onPressed: (){
                            FocusScopeNode currentFocus = FocusScope.of(context);

                            if (!currentFocus.hasPrimaryFocus) {
                              FocusScope.of(context).requestFocus(FocusNode());
                            }
                            setState(() {
                              signUpChecker == 1?signUpChecker = 2:signUpChecker=1;
                              emailController.text = "";
                              passwordController.text = "";
                            });
                          },
                          child:
                          Container(
                            width: width*0.8,
                            height: 50,
                            decoration: BoxDecoration(
                                color: const Color.fromRGBO(207, 92, 54, 1),
                                borderRadius: BorderRadius.circular(30)
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.check_rounded),
                                Text("Sign in!", style: TextStyle(color: Color.fromRGBO(239, 200, 139, 1)),)
                              ],
                            ),
                          )
                      ),
                    )  : Container(),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}
