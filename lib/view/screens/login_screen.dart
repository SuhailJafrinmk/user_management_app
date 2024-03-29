import 'package:flutter/material.dart';
import 'package:user_management/controller/firebase_methods.dart';
import 'package:user_management/view/screens/signup_page.dart';
import 'package:user_management/view/themes/theme_file.dart';
import 'package:lottie/lottie.dart';
import 'package:user_management/view/widgets/custom_buttton.dart';
import 'package:user_management/view/widgets/custom_textfield.dart';
import 'package:user_management/view/widgets/image_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formkey=GlobalKey<FormState>();
  bool hideText=false;
  bool isLoading=false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
      double height = MediaQuery.of(context).size.height;
  double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            //animated image
            SizedBox(
              height: height * .3,
              width: width,
              child: Lottie.asset(
                  'assets/lottie_animation/Animation - 1710831799770.json'),
            ),
            Text(
              'Welcome Back!',
              style: AppThemeSetter.setTextStyle(
                  size: 30, fontWeight: FontWeight.w500),
            ),

            //textfield for name
            Expanded(
              child: Form(
                key: formkey,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Container(
                        decoration: const BoxDecoration(
                         borderRadius: BorderRadius.all(Radius.circular(30)),
                          color: Colors.white,
                        ),
                        child: Column(children: [
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 10, top: 20),
                            child: LoginTextField(
                              validator: (value) {
                                final pattern =RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                              
                                if(value==null||value.isEmpty){
                                  return 'Enter an Email id';
                                }
                                if(!pattern.hasMatch(value)){
                                  return 'Enter a valid Email';
                                }
                                return null;
                              },
                              obscureText: false,
                              prefixIconWidget: const Icon(Icons.account_circle_rounded),
                                controller: emailController,
                                hintText: 'Enter Your Email',
                                labelText: 'Email'),
                          ),
                            Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 10, top: 10),
                            child: LoginTextField(
                              validator: (value) {
                                if(value==null||value.isEmpty){
                                  return 'Enter your password';
                                }
                                return null;
                              },
                              obscureText: hideText,
                              prefixIconWidget: const Icon(Icons.lock),
                              sufixIconWidget: IconButton(onPressed: (){
                                setState(() {
                                  hideText==false ? hideText=true : hideText=false;
                                });
                              }, icon: Icon(hideText==false ? Icons.visibility : Icons.visibility_off)),
                                controller: passwordController,
                                hintText: 'Enter Your Password',
                                labelText: 'Password'),
                          ),
                         
                          const SizedBox(
                            height: 10,
                          ),
                          CustomButton(
                              height: 60,
                              width: width * .84,
                              elevation: 20,
                              color: Colors.teal.shade800,
                              onTap: () {
                                if(formkey.currentState!.validate()){
                                  // final data=UserModel(userEmail: emailController.text,password: passwordController.text);
                                  // FireBaseHelper.checkSignIn(data,context);
                                  final Password=passwordController.text;
                                  final email=emailController.text;
                                  FireBaseHelper.signInWithEmailAndPassword(email, Password,context);
                                  emailController.clear();
                                  passwordController.clear();
                                print('tapped');
                                }else{
                                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Provide right credentials')));
                                }
                              },
                              radius: 20,
                              child: Text(
                                'Login',
                                style: AppThemeSetter.setTextStyle(
                                    size: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              )),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                   Text('don\'t have an account',style: AppThemeSetter.setTextStyle(size: 13, fontWeight: FontWeight.w400,color: Colors.grey),),
                                  TextButton(onPressed: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpPage()));
                                  }, child: const Text("SignUp"))
                                ],
                              ),
                              const SizedBox(height: 10,),
                              const Text('-------Or Signup with-------'),
                              const SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ImageButton(height: 50, width: 50, elevation: 0, onTap: (){
                                    print('google tapped');
                                    FireBaseHelper.handleGoogleSignIn(context);
                                  }, radius: 0, assetImage:'assets/images/google_2991148.png' ),
                                  const SizedBox(width: 10,),
                                  ImageButton(height: 50, width: 50, elevation: 0, onTap: (){
                                    print('facebook tapped');
                                  }, radius: 0, assetImage: 'assets/images/facebook_5968764.png')
                                ],
                              ),
                              SizedBox(height: 20,)
                        ])),
                  ),
                ),
              ),
            )

            //textfield password
          ],
        ),
      ),
    );
  }
}
