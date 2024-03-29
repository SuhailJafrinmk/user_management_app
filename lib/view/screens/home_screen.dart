import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:user_management/controller/firebase_methods.dart';
import 'package:user_management/controller/pick_image.dart';
import 'package:user_management/view/themes/theme_file.dart';


class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
final current=FirebaseAuth.instance.currentUser;
 XFile ? pickedImage;
String ? imageurl;
String defaultImage='https://firebasestorage.googleapis.com/v0/b/user-management-8dcde.appspot.com/o/images%2Fexample.png?alt=media&token=f16004fa-db67-471c-b070-9a8b865f9c68';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
        actions: [
          IconButton(onPressed: (){
            FireBaseHelper.logoutFromAccount(context);
          }, icon: Icon(Icons.logout))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('userdata').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final users = snapshot.data?.docs;
            if (users == null || users.isEmpty) {
              return Center(
                child: Text('No users found'),
              );
            } else {
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final userData = users[index].data();
                  if (userData is Map<String, dynamic>) {
                    return ListTile(
                      leading: CircleAvatar(
                        
                      ),
                      title: Text(userData['userName'] ?? ''),
                      onTap: ()async{
                        if(current!.email==userData['userEmail']){
                          print('exactly');
                         await showDialog(context: context, builder: (BuildContext context){
                          return AlertDialog(
                            contentPadding: EdgeInsets.all(6),
                            title: Text('view details'),
                            content: SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.teal.shade800,
                                  borderRadius: BorderRadius.circular(20),
                      

                                ),
                                height: AppThemeSetter.setHeight(context)*.5,
                                width: AppThemeSetter.setWidth(context)*.8,
                                
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 20,width: 30,),
                                    Row(children: [
                                      SizedBox(width: AppThemeSetter.setWidth(context)*.25,),
                                      CircleAvatar(
                                        radius: 30,child: IconButton(onPressed: ()async{
                                       print('tapped..tapped');
                                       ImagePicker  picker=ImagePicker();
                                       pickedImage=await picker.pickImage(source: ImageSource.gallery) ?? XFile('assets/images/vecteezy_icon-image-not-found-vector_.jpg');          
                                       imageurl= await ImageSetter.addImageToCloud(pickedImage!);
                                       ImageSetter.addImageToDb(imageurl!,userData['uId']);
                                       

                                      }, icon: Icon(Icons.add)),),
                                    ],),
                                    SizedBox(height: 20,),
                                    Text('user:${userData['userName']}',style: AppThemeSetter.setTextStyle(size: 20, fontWeight: FontWeight.w500,color: Colors.white),),
                                    Text('email:${userData['userEmail']}',style: AppThemeSetter.setTextStyle(size: 20, fontWeight: FontWeight.w500,color: Colors.white),),
                                    Text('age:${userData['userAge']}',style: AppThemeSetter.setTextStyle(size: 20, fontWeight: FontWeight.w500,color: Colors.white)),
                                    Text('phone:${userData['userPhone']}',style: AppThemeSetter.setTextStyle(size: 20, fontWeight: FontWeight.w500,color: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                          );

                         });
                        }
                      }
                    );
                  } else {
                    return ListTile(
                      title: Text('Invalid User Data'),
                    );
                  }
                },
              );
            }
          }
        },
      ),
    );
  }


}
