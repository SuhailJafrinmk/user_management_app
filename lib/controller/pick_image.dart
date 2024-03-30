
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageSetter{
String ? imageUrl;
ImagePicker picker=ImagePicker();
addImageToDb(String email,BuildContext context,ImageSource source)async{
  XFile ? pickedImage=await picker.pickImage(source: source);
  try{
    if(pickedImage!=null){
      String fileName='images/${DateTime.now().millisecondsSinceEpoch}.png';
      Reference reference=FirebaseStorage.instance.ref().child(fileName);
      await reference.putFile(File(pickedImage.path))
      .whenComplete(() => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('image added'))));
      imageUrl=await reference.getDownloadURL();
      await FirebaseFirestore.instance
      .collection('userdata')
      .where('userEmail',isEqualTo: email)
      .get()
      .then((QuerySnapshot){
        QuerySnapshot.docs.forEach((doc) {
          doc.reference.update({'userProfile':imageUrl});
         });
      });
    }
  }catch(e){
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Erroorr,failed to upload image"),
        ),
      );
  }
}

 



}