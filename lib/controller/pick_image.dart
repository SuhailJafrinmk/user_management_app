
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class ImageSetter{
static XFile image=imageSetter();
static String defaultImage='https://firebasestorage.googleapis.com/v0/b/user-management-8dcde.appspot.com/o/images%2Fexample.png?alt=media&token=f16004fa-db67-471c-b070-9a8b865f9c68';
static imageSetter()async{
  ImagePicker picker=ImagePicker();
  XFile? image=await picker.pickImage(source:ImageSource.gallery );
  if(image==null){
    return XFile('assets/images/vecteezy_icon-image-not-found-vector_.jpg');
  }
  return image;
}
 static Future<String>addImageToCloud(XFile image)async{
  Reference reference=FirebaseStorage.instance.ref().child('images').child('example.png');
  reference.putFile(File(image.path));
  String imageUrl=await reference.getDownloadURL();
  return imageUrl;
 }

static addImageToDb(String imageUrl,String uId){
  CollectionReference reference=FirebaseFirestore.instance.collection('userdata');
  DocumentReference userrefer=reference.doc(uId);
  userrefer.update({'profileImage':imageUrl});
  print('iamge url is-----------------$imageUrl');

}
 



}