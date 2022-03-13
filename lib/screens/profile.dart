import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/src/provider.dart';
import 'package:untitled2/services/authentication_service.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  ImagePicker _picker = ImagePicker();

  Image? profileImage;

  String? _name;
  String? _email;
  String _imageUrl = "";
  String _id = "";
  String _joinedAt = "";
  String _displayName = "";
  var _favs = [];

  @override
  void initState() {

    super.initState();
    getData();
  }

  Future<void> getData()async{
    User user = context.read<AuthenticationService>().getUser()!;
    setState(() {
      _id = user.uid;
    });
    final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection("users").doc(_id).get();
      _email = userDoc.get('email');
      _name = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
      _imageUrl = userDoc.get('imageUrl');
      _joinedAt = userDoc.get('joinedAt');
      _favs = userDoc.get("favorites");
    print("I ran");
  }

  @override
  Widget build(BuildContext context) {


    setState(() {

    });

    double width = MediaQuery.of(context).size.width;

    double height = MediaQuery.of(context).size.height;

    double form = (width-15)/(height*0.02);
    print(form);


    return MediaQuery(
      data: MediaQuery.of(context),
      child: Scaffold(
          backgroundColor: Color.fromRGBO(245, 245, 240, 1),
          appBar: AppBar(
            backgroundColor: Color.fromRGBO(245, 245, 240, 1),
            elevation: 0,
            title: Text("Profile", style: TextStyle(color: Colors.black),),
            leading: IconButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back, color: Colors.black,)
            ),
        ),
        body: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(
                      MediaQuery.of(context).size.height * 0.03,
                      MediaQuery.of(context).size.height * 0.03,
                      MediaQuery.of(context).size.height * 0.03,
                      10),
                  child: Stack(
                    children: [
                      Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () async {
                                  return await showDialog(
                                    barrierColor:
                                    Colors.grey.withOpacity(0.2),
                                    context: context,
                                    builder: (_) => Dialog(
                                      backgroundColor:
                                      Colors.grey.withOpacity(0.1),
                                      child: Container(
                                        height: 400,
                                        width: 400,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    _imageUrl))),
                                      ),
                                    ),
                                  );
                                  },
                                child: Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.purple,
                                          style: BorderStyle.solid,
                                          width: 4),
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: _imageUrl == ""
                                            ? const NetworkImage(
                                            "https://firebasestorage.googleapis.com/v0/b/foody-bee39.appspot.com/o/ProfileImages%2Fdefault%2Fuser.png?alt=media&token=597b7db5-e824-4322-88e1-04702850349d")
                                            : NetworkImage(_imageUrl)
                                        as ImageProvider,
                                      )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: () async {
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
                                          imageQuality: 10);
                                      File file = File(pickedFile!.path);
                                      final ref = FirebaseStorage.instance
                                          .ref()
                                          .child("ProfileImages")
                                          .child("${_id}");
                                      await ref.putFile(file);
                                      String link = await ref.getDownloadURL();
                                      FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(_id)
                                          .set({
                                        'imageUrl': link,
                                        'id': _id,
                                        'name': _name,
                                        'email': _email,
                                        'joinedAt': _joinedAt,
                                        'displayedName': _displayName,
                                        'favorites': _favs
                                      });
                                      setState(() {
                                        _imageUrl = link;
                                      });
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
                                          imageQuality: 10);
                                      File file = File(pickedFile!.path);
                                      final ref = FirebaseStorage.instance
                                          .ref()
                                          .child("ProfileImages")
                                          .child("${_id}");
                                      await ref.putFile(file);
                                      String link = await ref.getDownloadURL();
                                      FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(_id)
                                          .set({
                                        'imageUrl': link,
                                        'id': _id,
                                        'name': _name,
                                        'email': _email,
                                        'joinedAt': _joinedAt,
                                        'displayedName': _displayName,
                                        'favorites': _favs
                                      });
                                      setState(() {
                                        _imageUrl = link;
                                      });
                                    },
                                    child: ListTile(
                                      leading: Icon(Icons.image_outlined, size: 30,),
                                      title: Text("From gallery", style: TextStyle(fontSize: 20)),
                                    ),
                                  )
                                ],
                              )
                            );
                          },
                          child: Container(
                              height: 30,
                              width: 30,
                              decoration: const BoxDecoration(
                                  color: Colors.grey,
                                  shape: BoxShape.circle),
                              child: const Icon(
                                Icons.create,
                                color: Colors.white,
                              )),
                        ),
                      )
                    ],
                  ),
                ),
                Text(
                  _joinedAt,
                  style: const TextStyle(
                      fontStyle: FontStyle.italic, color: Colors.grey),
                ),
              ],
            ),
            Column(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: height*0.04,
                    width: width - 25,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Center(
                          child: FutureBuilder(
                              future: getData(),
                              builder: (context, snapshot) {
                                print(_name!);
                                if(snapshot.connectionState == ConnectionState.waiting){
                                  return RefreshProgressIndicator();
                                }
                                else{
                                  return RichText(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      text: TextSpan(
                                          text: "Name: ",
                                          style: TextStyle(
                                              fontSize: height * 0.02,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black
                                          ),
                                          children: [
                                            TextSpan(
                                              text: _name,
                                              style: TextStyle(
                                                  fontSize: height * 0.02,
                                                  fontWeight: FontWeight.normal),
                                            )
                                          ]
                                      )
                                  );
                                }
                              }
                        )
                    ),
                  ),
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(119, 118, 188, 1)
                            .withOpacity(0.4),
                        borderRadius:
                        const BorderRadius.all(Radius.circular(10))),
                  )
                ),
                const SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: height*0.04,
                    width: width - 25,
                    child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Row(
                          children: [
                             Text(
                              "E-mail: ",
                              style: TextStyle(
                                  fontSize: height*0.02,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
                            Text(
                              _email!,
                              overflow: TextOverflow.ellipsis,
                              style:  TextStyle(
                                  fontSize: height*0.02,
                                  fontWeight: FontWeight.normal),
                            )
                          ],
                        )),
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(119, 118, 188, 1)
                            .withOpacity(0.4),
                        borderRadius:
                        BorderRadius.all(Radius.circular(10))),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () async {
                      await context
                          .read<AuthenticationService>()
                          .forgetPassword(email: _email);
                      SnackBar snackbar =
                      SnackBar(content: Text("E-mail sent!"));
                      ScaffoldMessenger.of(context).showSnackBar(snackbar);
                      },
                    child: FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RichText(
                              text: const TextSpan(
                                text: 'Change Password!',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                children: <TextSpan>[],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],)
        ),
    );
  }
}
