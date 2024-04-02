import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginTextField extends StatelessWidget {
  FocusNode ? focusNode;
  void Function(String)? onChanged;
  bool  obscureText;
  Color ? suffixIconColor;
  Color ? prefixIconColor;
  Widget ?sufixIconWidget;
  Widget ?prefixIconWidget;
  bool? isFilled;
  TextEditingController controller;
  String hintText;
  String labelText;
  String? Function(String?)? validator;
  LoginTextField({this.focusNode,this.onChanged,required this.obscureText,this.prefixIconWidget,this.prefixIconColor,this.sufixIconWidget,this.suffixIconColor,this.isFilled,required this.controller,
  required this.hintText,required this.labelText,this.validator});
  @override
  Widget build(BuildContext context){
    return TextFormField(
      focusNode: focusNode,
      onChanged: onChanged,
      obscureText: obscureText,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        suffixIconColor: suffixIconColor,
        prefixIconColor: prefixIconColor,
        prefixIcon: prefixIconWidget,
        suffixIcon: sufixIconWidget,
        labelStyle: TextStyle(
          color: Colors.teal.shade800,
        ),
        filled: isFilled,
        fillColor: Colors.transparent,
        hintText: hintText,
        labelText: labelText,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.teal.shade800,
          )
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

}