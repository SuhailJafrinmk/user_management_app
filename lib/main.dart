

import 'package:flutter/material.dart';
import 'package:user_management/view/screens/splash_screen.dart';
import 'package:user_management/view/themes/theme_file.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  Widget build(BuildContext context){
    return  MaterialApp(
      theme: AppThemeSetter.appTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}