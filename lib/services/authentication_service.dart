import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class AuthenticationService{
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(this._firebaseAuth);

  Stream<User?> get authService => _firebaseAuth.authStateChanges();

  Future<String> signIn({String? email, String? password}) async{
    try{
      await _firebaseAuth.signInWithEmailAndPassword(email: email!, password: password!);
      print("joined in");
      return "Signed in";
    }on FirebaseAuthException catch(e){
      return e.message!;
    }
  }

  Future<String> signUp({String? name, String? email, String? password}) async{

    var date = DateTime.now();
    print(date);
    try{
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email!, password: password!);
      final user = _firebaseAuth.currentUser;
      await FirebaseFirestore.instance.collection("users").doc(user!.uid).set({
        'id': user.uid,
        'name': name,
        'email': user.email,
        'imageUrl': '',
        'joinedAt': "${date.day}/${date.month}/${date.year}",
        'displayName': '',
        'favorites': []
      });
      _firebaseAuth.currentUser!.updateDisplayName(name);
      return "Signed up";
    }on FirebaseAuthException catch(e){
      return e.message!;
    }
  }

  Future<String> forgetPassword({String? email}) async{
    try{
      print(4);
      await _firebaseAuth.sendPasswordResetEmail(email: email!);
      print(5);
      return "Signed up";
    }on FirebaseAuthException catch(e){
      return e.message!;
    }
  }

  String? getDisplayName(){
    return _firebaseAuth.currentUser!.displayName;
  }

  String? getName() {
    return _firebaseAuth.currentUser!.displayName;
  }

  String? getEmail() {
    return _firebaseAuth.currentUser!.email;
  }

  User? getUser() {
    return _firebaseAuth.currentUser!;
  }


  Future<String> signOut() async{
    try{
      await _firebaseAuth.signOut();
      return "Signed out";
    }on FirebaseAuthException catch(e){
      return e.message!;
    }
  }
}