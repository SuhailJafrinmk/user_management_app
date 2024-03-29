

class UserModel{
  String? uId;
  String? userName;
  String? userEmail;
  String? userAge;
  String? userPhone;
 
  

  UserModel({this.uId,this.userName,this.userEmail,this.userAge,this.userPhone});
  Map<String,dynamic> toMap(){
    return {
      'uId':uId,
      'userEmail':userEmail,
      'userName':userName,
      'userAge':userAge,
      'userPhone':userPhone,
    };
  }

  factory UserModel.fromMap(Map<String,dynamic>data){
    return UserModel(
      uId:data['uId'],
      userName: data['userName'],
      userEmail: data['userEmail'],
      userAge: data['userAge'],
      userPhone: data['userPhone'],
    );
  }


}