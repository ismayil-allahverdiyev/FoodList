import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Comments extends StatelessWidget {

  List<dynamic>? friendsList;

  Comments({this.friendsList});



  @override
  Widget build(BuildContext context) {

    List<Widget> comments = [];

    friendsList!.forEach((element) {

      String? image;

      Future<void> getPicture()async{
        image = await FirebaseFirestore.instance.collection('users').doc(element['uid']).get().then((value) => value['imageUrl']);
      }

      print(element['uid']);

      comments.add(
          ListTile(
            leading: FutureBuilder(
              future: getPicture(),
              builder: (context, snapshot) {
                if(snapshot.connectionState ==ConnectionState.waiting){
                  return CircularProgressIndicator();
                }else {
                  return CircleAvatar(
                    backgroundColor: Colors.white,
                  backgroundImage: image == "" ? NetworkImage("https://firebasestorage.googleapis.com/v0/b/foody-bee39.appspot.com/o/ProfileImages%2Fdefault%2Fuser.png?alt=media&token=597b7db5-e824-4322-88e1-04702850349d") : NetworkImage(image!),
                );
              }
            }
            ),
            title: Text(element['comment']),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: "by: ", style: TextStyle(fontWeight: FontWeight.w700, color: Colors.black)),
                    TextSpan(text: element['name'],style: TextStyle(color: Colors.indigo[800], fontWeight: FontWeight.normal, fontStyle: FontStyle.italic))
                  ]
                ),
              ),
            ),
            trailing: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(element['date']['day'], style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),),
                  Text(element['date']['time'], style: TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),),
                ],
              ),
            ),
      ));
      comments.add(Divider(height: 1, thickness: 1,));
    });
    return ListView(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: comments,
    );
  }
}
