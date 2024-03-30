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
  ImageSetter imageSetter = ImageSetter();
  final current = FirebaseAuth.instance.currentUser;
  String? imageUrl;
  String defaultImage =
      'https://images.wondershare.com/repairit/aticle/2021/07/resolve-images-not-showing-problem-1.jpg';
  void selectImage(String email) async {
    String? img=await imageSetter.addImageToDb(email, context, ImageSource.gallery);
        
    setState(() {
      imageUrl = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:  Text('UserList',style: AppThemeSetter.setTextStyle(size: 25, fontWeight: FontWeight.w500,color: Colors.white),),
        actions: [
          IconButton(
              onPressed: () {
                FireBaseHelper.logoutFromAccount(context);
              },
              icon: const Icon(Icons.logout,color: Colors.white,))
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('userdata').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            final users = snapshot.data?.docs;
            if (users == null || users.isEmpty) {
              return const Center(
                child: Text('No users found'),
              );
            } else {
              return ListView.separated(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final userData = users[index].data();
                  if (userData is Map<String, dynamic>) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                          style: ListTileStyle.list,
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                                userData['userProfile'] ?? defaultImage),
                          ),
                          title: Text(userData['userName'] ?? ''),
                          onTap: () async {
                            if (current!.email == userData['userEmail']) {
                              print('exactly');
                              await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.teal.shade800,
                                      contentPadding: const EdgeInsets.all(6),
                                      title: const Text('view details'),
                                      content: SingleChildScrollView(
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: Colors.teal.shade800,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          height:
                                              AppThemeSetter.setHeight(context) *
                                                  .5,
                                          width:
                                              AppThemeSetter.setWidth(context) *
                                                  .8,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                                width: 30,
                                              ),
                                              Row(
                                                children: [
                                                  SizedBox(
                                                    width:
                                                        AppThemeSetter.setWidth(
                                                                context) *
                                                            .25,
                                                  ),
                                                  CircleAvatar(
                                                    radius: 30,
                                                    child: IconButton(
                                                        onPressed: () async {
                                                          print('tapped..tapped');
                                                          selectImage(userData[
                                                              'userEmail']);
                                                        },
                                                        icon: const Icon(Icons.add)),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                'user:${userData['userName']}',
                                                style:
                                                    AppThemeSetter.setTextStyle(
                                                        size: 20,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white),
                                              ),
                                              Text(
                                                'email:${userData['userEmail']}',
                                                style:
                                                    AppThemeSetter.setTextStyle(
                                                        size: 20,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: Colors.white),
                                              ),
                                              Text('age:${userData['userAge']}',
                                                  style:
                                                      AppThemeSetter.setTextStyle(
                                                          size: 20,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white)),
                                              Text(
                                                  'phone:${userData['userPhone']}',
                                                  style:
                                                      AppThemeSetter.setTextStyle(
                                                          size: 20,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.white)),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            }
                          }),
                    );
                  } else {
                    return const ListTile(
                      title: Text('Invalid User Data'),
                    );
                  }
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
              );
            }
          }
        },
      ),
    );
  }
}
