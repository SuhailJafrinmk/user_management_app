import 'package:flutter/material.dart';
import 'package:user_management/controller/firebase_methods.dart';
import 'package:user_management/view/themes/theme_file.dart';
import 'package:user_management/view/widgets/custom_buttton.dart';
import 'package:user_management/view/widgets/custom_textfield.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ageController = TextEditingController();
  final phoneNoControlller = TextEditingController();
  final formkey = GlobalKey<FormState>();

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    ageController.dispose();
    phoneNoControlller.dispose();
    emailController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                SizedBox(
                  width: AppThemeSetter.setWidth(context),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Sign up',
                        style: AppThemeSetter.setTextStyle(
                            size: 40,
                            fontWeight: FontWeight.w600,
                            color: Colors.teal.shade800),
                      ),
                      Text(
                        'Create your Account',
                        style: AppThemeSetter.setTextStyle(
                            size: 20,
                            fontWeight: FontWeight.w300,
                            color: Colors.teal.shade800),
                      ),
                      const SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),


                //field for username////////////////////////////////
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 10, top: 10),
                  child: LoginTextField(
                    onChanged: (value) {
                      setState(() {
                        userNameController.text=value;
                      });
                    },
                      validator: (value) {
                        final pattern = RegExp(r'^[a-zA-Z0-9_-]{3,20}$');
                        if (value == null || value.isEmpty) {
                          return 'Please enter a value';
                        }
                        if (!pattern.hasMatch(value)) {
                          return 'Enter valid username';
                        }
                        return null;
                      },
                      obscureText: false,
                      prefixIconWidget:
                          const Icon(Icons.account_circle_rounded),
                      controller: userNameController,
                      hintText: 'Enter Your Username',
                      labelText: 'Username'),
                ),


                //field for email id////////////////////////////////
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 10, top: 10),
                  child: LoginTextField(
                    onChanged: (value) {
                      emailController.text=value;
                    },
                      validator: (value) {
                        final pattern =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (value == null || value.isEmpty) {
                          return 'Enter an Email id';
                        }
                        if (!pattern.hasMatch(value)) {
                          return 'Enter a valid email';
                        }
                        return null;
                      },
                      obscureText: false,
                      prefixIconWidget: const Icon(Icons.email),
                      controller: emailController,
                      hintText: 'Enter Your Email',
                      labelText: 'Email'),
                ),


                //field for password////////////////////////////
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 10, top: 10),
                  child: LoginTextField(
                    onChanged:(value) {
                      passwordController.text=value; 
                    },
                      validator: (value) {
                        final pattern = RegExp(
                            r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                        if (value == null || value.isEmpty) {
                          return 'Please enter a password';
                        }
                        if (!pattern.hasMatch(value)) {
                          return 'Enter a valid password';
                        }
                        return null;
                      },
                      obscureText: false,
                      prefixIconWidget: const Icon(Icons.key),
                      controller: passwordController,
                      hintText: 'Enter Your Password',
                      labelText: 'Password'),
                ),


                //field for adding age/////////////////////////////
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 10, top: 10),
                  child: LoginTextField(
                    onChanged: (value) {
                      ageController.text=value;
                      
                    },
                      validator: (value) {
                        final pattern = RegExp(r'^(1[0-9]|[2-9][0-9]|100)$');
                        if (value == null || value.isEmpty) {
                          return 'Please enter your age';
                        }
                        if (!pattern.hasMatch(value)) {
                          return 'Age should be more than 10';
                        }
                        return null;
                      },
                      obscureText: false,
                      prefixIconWidget: const Icon(Icons.key),
                      controller: ageController,
                      hintText: 'Enter Your age',
                      labelText: 'Age'),
                ),


                //field for adding mobile number////////////////////
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 10, top: 10),
                  child: LoginTextField(
                    onChanged:(value) {
                      phoneNoControlller.text=value;
                      
                    },
                      validator: (value) {
                        final pattern = RegExp(r'^[6-9]\d{9}$');
                        if (value == null || value.isEmpty) {
                          return 'Please enter your mobile number';
                        }
                        if (!pattern.hasMatch(value)) {
                          return 'Enter a valid mobile number';
                        }
                        return null;
                      },
                      obscureText: false,
                      prefixIconWidget: const Icon(Icons.key),
                      controller: phoneNoControlller,
                      hintText: 'Enter Your mobile number',
                      labelText: 'Mobile no'),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                    height: 60,
                    width: AppThemeSetter.setWidth(context) * .9,
                    elevation: 20,
                    color: Colors.teal.shade800,
                    onTap: () {
                      if (!formkey.currentState!.validate()) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('input not valid')));
                      } else {
                        FireBaseHelper.signup(
                            userNameController.text,
                            emailController.text,
                            ageController.text,
                            phoneNoControlller.text,
                            passwordController.text,
                            context);
                      }
                    },
                    radius: 20,
                    child: Text(
                      'Submit',
                      style: AppThemeSetter.setTextStyle(
                          size: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
