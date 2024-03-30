
// import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:user_management/view/screens/home_screen.dart';
// import 'package:user_management/view/screens/login_screen.dart';
// import 'package:user_management/view/themes/theme_file.dart';

// class SplashScreen extends StatefulWidget {
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
// class _SplashScreenState extends State<SplashScreen> {
//   @override

// bool  ? signedin;


//  checkSigned()async{
//     final shared=await SharedPreferences.getInstance();
//     setState(() {
//       signedin=shared.getBool('isLogged');
//     });
//     print('value of signed in is $signedin');
//   }

//   @override
//   Widget build(BuildContext context) {
//     checkSigned();
//     return FlutterSplashScreen.fadeIn(
//       duration: Duration(seconds: 3),
//       backgroundColor: Colors.teal.shade800,
//       childWidget: Center(child: RichText(text: TextSpan(children: [
//         TextSpan(text: 'USER',style: AppThemeSetter.setTextStyle(size: 60, fontWeight: FontWeight.w500,color: Colors.white)),
//         TextSpan(text: 'VAULT',style: AppThemeSetter.setTextStyle(size: 30, fontWeight: FontWeight.w500,color: Colors.white)),
//     ]),),),
//       onEnd: () => signedin==true ? Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen())) : Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen())),

     
//     );
//   }
// }


import 'dart:async';

import 'package:flutter/material.dart';
import 'package:user_management/view/screens/boarding_screen.dart';

import 'package:user_management/view/themes/theme_file.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    nextScreen();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade800,
      body:  Center(child: RichText(text: TextSpan(children: [
        TextSpan(text: 'USER',style: AppThemeSetter.setTextStyle(size: 60, fontWeight: FontWeight.w500,color: Colors.white)),
        TextSpan(text: 'VAULT',style: AppThemeSetter.setTextStyle(size: 30, fontWeight: FontWeight.w500,color: Colors.white)),
    ]),),),
    );
  }
   void nextScreen() async {
    // SharedPreferences sharedpref = await SharedPreferences.getInstance();
    // bool ? isLoggedin = sharedpref.getBool('isLogged');
    // print('value of logged in is $isLoggedin');

    Timer(const Duration(seconds: 3), () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>BoardingScreen()));
      // isLoggedin != null
      //     ? isLoggedin
      //         ? Navigator.pushReplacement(context,
      //             MaterialPageRoute(builder: (context) =>  HomeScreen()))
      //         : Navigator.pushReplacement(context,
      //             MaterialPageRoute(builder: (context) => const LoginScreen()))
      //     : Navigator.pushReplacement(context,
      //         MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
    );
  }
}