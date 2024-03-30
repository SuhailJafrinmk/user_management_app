import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_management/view/themes/theme_file.dart';

class BoardingScreen extends StatefulWidget {
  const BoardingScreen({super.key});

  @override
  State<BoardingScreen> createState() => _BoardingScreenState();
}

class _BoardingScreenState extends State<BoardingScreen> {
  bool ? value;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: AppThemeSetter.setHeight(context)*.6,
              width: AppThemeSetter.setWidth(context),
              child: Lottie.asset('assets/lottie_animation/boarding.json'),
            ),
            Expanded(child: SizedBox(
              width: AppThemeSetter.setHeight(context),
              height: AppThemeSetter.setHeight(context)*.4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Welcome to uservault',style: AppThemeSetter.setTextStyle(size: 35, fontWeight: FontWeight.w500,color: Colors.teal),),
                  Padding(padding: const EdgeInsets.all(10),child: Text('Manage your users efficiently with our powerful user management app. Easily add, edit, and delete user accounts with just a few taps',
                  style: AppThemeSetter.setTextStyle(size: 17, fontWeight: FontWeight.w200,color: Colors.teal),),),
                  const SizedBox(height: 30,),
                  InkWell(
                    onTap: () {
                      nextScreen();
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.teal.shade800,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Next',style: AppThemeSetter.setTextStyle(size: 16, fontWeight: FontWeight.normal,color: Colors.white),),
                          Icon(Icons.navigate_next_sharp,color: Colors.white,)
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
  void nextScreen()async{
    final SharedPreferences pref=await SharedPreferences.getInstance();
    setState(() {
      value=pref.getBool('isLogged');
    });
    print('the user is signed in $value');
    try{
      if(value!=null){
        if(value==true){
          Navigator.pushNamed(context, 'homescreen');
        }else{
          Navigator.pushNamed(context, 'loginscreen');
        }
      }
      Navigator.pushNamed(context, 'loginscreen');
    }catch(e){
      print('error accessing value $e');
      Navigator.pushNamed(context, 'loginscreen');
    }
  }
}