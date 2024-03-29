import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:user_management/model/user_model.dart';
import 'package:user_management/view/screens/home_screen.dart';
import 'package:user_management/view/screens/login_screen.dart';

class FireBaseHelper {
  
  //create a new account
  static signup(String user, String email, String age, String phone,
      String password,context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await FirebaseAuth.instance.currentUser!.updateDisplayName(email);
      final current = FirebaseAuth.instance.currentUser;
      UserModel usermode = UserModel(
          uId: current!.uid,
          userName: user,
          userEmail: email,
          userAge: age,
          userPhone: phone);

      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      await firebaseFirestore
          .collection('userdata')
          .doc(userCredential.user!.uid)
          .set(usermode.toMap());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Registeratered Successfully"),
        ),
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } on FirebaseException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Password Provided Is Too Weak"),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Email Provided Already Exists"),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  //sign in with email and password
  static Future<void> signInWithEmailAndPassword(
      String email, String password,context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => HomeScreen()));
      print('User signed in successfully');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Signed in succesfully')));
    } catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('user not found')));
      print('Failed to sign in: $e');
    }
  }


///google sign ----------------------------------------------
static void handleGoogleSignIn(context)async{
  try{
   GoogleSignInAccount? googleSignInAccount=await GoogleSignIn().signIn();
   if(googleSignInAccount!=null){
    GoogleSignInAuthentication auth=await googleSignInAccount.authentication;
    AuthCredential credential=GoogleAuthProvider.credential(idToken: auth.idToken,accessToken:auth.accessToken );
    UserCredential userCredential=await FirebaseAuth.instance.signInWithCredential(credential);
    await addUserToDatabase(userCredential.user,context);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('google signed in')));
    Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
    
   } 
  }catch(e){
    print('error!!!!!!$e');
  }
}

static Future<void> addUserToDatabase(user,context)async{
  try{
    CollectionReference reference=FirebaseFirestore.instance.collection('userdata');
    DocumentSnapshot snapshot=await reference.doc(user!.uid).get();
    if(!snapshot.exists){
      await reference.doc(user.uid).set({
        'userName':user.displayName,
        'userEmail':user.email,
        'uId':user.uid,
      });
      print('added to firestore');
    }
  }catch(e){
    print('error!!!!$e');
  }
}

//logout from account
static logoutFromAccount(context)async{
  try{
 FirebaseAuth firebaseAuth=FirebaseAuth.instance;
 await firebaseAuth.signOut();
  }catch(e){
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('error signing out')));
  }
 Navigator.pop(context);
}


}
