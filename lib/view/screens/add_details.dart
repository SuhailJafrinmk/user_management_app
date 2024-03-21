import 'package:flutter/material.dart';
import 'package:user_management/view/themes/theme_file.dart';
import 'package:user_management/view/widgets/custom_buttton.dart';
import 'package:user_management/view/widgets/custom_textfield.dart';

class AddDetails extends StatefulWidget {
  const AddDetails({super.key});

  @override
  State<AddDetails> createState() => _AddDetailsState();
}

class _AddDetailsState extends State<AddDetails> {
  @override
  Widget build(BuildContext context) {
    TextEditingController firstNameController = TextEditingController();
    TextEditingController secondNameController = TextEditingController();
    TextEditingController ageController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    GlobalKey<FormState>formkey=GlobalKey();


    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
              child: Form(
                key: formkey,
                child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 50,),
                        SizedBox(
                          width: AppThemeSetter.setWidth(context),
                          child: CircleAvatar(
                child: IconButton(onPressed: (){}, icon: Icon(Icons.add_a_photo_outlined),iconSize: 50,),
                radius: 100,
                          ),
                        ),
                        Padding(
                          padding:
                  const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
                          child: LoginTextField(
                            validator: (value) {
                              return value==null||value.isEmpty ? 'enter a data' : null;
                            },
                            obscureText: false,
                  prefixIconWidget: const Icon(Icons.account_circle_rounded),
                  controller: firstNameController,
                  hintText: 'Enter Your Firstname',
                  labelText: 'Firstname'),
                        ),
                        Padding(
                          padding:
                  const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
                          child: LoginTextField(
                            validator: (value) {
                             return  value==null||value.isEmpty ? 'enter a data' : null;
                            },
                            obscureText: false,
                  prefixIconWidget: const Icon(Icons.account_circle_rounded),
                  controller: secondNameController,
                  hintText: 'Enter Your Secondname',
                  labelText: 'Secondname'),
                        ),
                        Padding(
                          padding:
                  const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
                          child: LoginTextField(
                            validator: (value) {
                              return value==null||value.isEmpty ? 'enter a data' : null;
                            },
                            obscureText: false,
                  prefixIconWidget: const Icon(Icons.calendar_today),
                  controller: ageController,
                  hintText: 'Enter your Age',
                  labelText: 'Age'),
                        ),
                        Padding(
                          padding:
                  const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
                          child: LoginTextField(
                            validator: (value) {
                              return value==null||value.isEmpty ? 'enter a data' : null;
                            },
                            obscureText: false,
                  prefixIconWidget: Icon(Icons.email),
                  controller: emailController,
                  hintText: 'Enter Your Email id',
                  labelText: 'Email'),
                        ),
                        SizedBox(height: 20,),
                        CustomButton(
                child: Text(
                  'Submit',
                  style: AppThemeSetter.setTextStyle(
                      size: 20, fontWeight: FontWeight.w500, color: Colors.white),
                ),
                height: 60,
                width: AppThemeSetter.setWidth(context) * .9,
                elevation: 10,
                color: Colors.teal.shade800,
                onTap: () {
                  if(!formkey.currentState!.validate()){
                    print('input not valid');
                  }else{
                    print('validated');
                  }
                },
                radius: 10)
                      ],
                    ),
              ),
            )));
  }
}
