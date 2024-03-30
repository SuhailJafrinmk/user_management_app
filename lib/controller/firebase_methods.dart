

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_management/model/user_model.dart';
import 'package:user_management/view/screens/home_screen.dart';
import 'package:user_management/view/screens/login_screen.dart';

class FireBaseHelper {
  static Future<void> setLogin(bool isLogged) async {
  try {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool('isLogged', isLogged);
    print('Login status set successfully');
  } catch (e) {
    print('Failed to set login status: $e');
  }
}


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
          context, MaterialPageRoute(builder: (context) => const LoginScreen()));
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



  static Future<void> signInWithEmailAndPassword(String email, String password, BuildContext context) async {
  try {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          backgroundColor: Colors.transparent,
          content: Center(
            child: CircularProgressIndicator(),
          )
        );
      },
    );

    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    setLogin(true);
    Navigator.pop(context);
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));

    print('User signed in successfully');
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Signed in successfully')));
  } catch (e) {
    Navigator.pop(context);

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to sign in: $e')));
    print('Failed to sign in: $e');
  }
}



static void handleGoogleSignIn(BuildContext context) async {
  try {

    showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext context) {
        return const AlertDialog(
          backgroundColor: Colors.transparent,
          content: Center(
            child: CircularProgressIndicator(),
          )
        );
      },
    );

    GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
    if (googleSignInAccount != null) {
      GoogleSignInAuthentication auth = await googleSignInAccount.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(idToken: auth.idToken, accessToken: auth.accessToken);
      UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      await addUserToDatabase(userCredential.user, context);

      Navigator.pop(context);


      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Google signed in')));

      setLogin(true);

Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  } catch (e) {
    Navigator.pop(context);
    print('Error: $e');
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
      showDialog(
      context: context,
      barrierDismissible: false, 
      builder: (BuildContext context) {
        return const AlertDialog(
          backgroundColor: Colors.transparent,
          content: Center(
            child: CircularProgressIndicator(),
          )
        );
      },
    );
 FirebaseAuth firebaseAuth=FirebaseAuth.instance;
 GoogleSignIn googleSignIn=GoogleSignIn();
 await firebaseAuth.signOut();
 await googleSignIn.signOut();
 print('signed out from account');
 Navigator.pop(context);
 setLogin(false);
 Navigator.popAndPushNamed(context, 'loginscreen');
}catch(e){
ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('error signing out')));
}

}




static Future<void> deleteUser(String id,BuildContext context)async{
  try{
   final storage=FirebaseFirestore.instance;
   final reference=storage.collection('userdata').doc(id);
   await reference.delete();
  }catch(e){
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('error occured while deleting user')));
  }
}


}
