
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:user_management/view/screens/login_screen.dart';
import 'package:user_management/view/themes/theme_file.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterSplashScreen.fadeIn(
      duration: Duration(seconds: 3),
      backgroundColor: Colors.teal.shade800,
      nextScreen: LoginScreen(),
      childWidget: Center(child: RichText(text: TextSpan(children: [
        TextSpan(text: 'USER',style: AppThemeSetter.setTextStyle(size: 60, fontWeight: FontWeight.w500,color: Colors.white)),
        TextSpan(text: 'VAULT',style: AppThemeSetter.setTextStyle(size: 30, fontWeight: FontWeight.w500,color: Colors.white)),
    ]),),));
  }
}
