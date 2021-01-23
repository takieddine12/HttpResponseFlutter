
class UserModel {
  int userId;
  int id;
  String title;
  String body;

  UserModel({this.userId,this.id,this.title,this.body});

  factory UserModel.from(Map<String,dynamic> json){
    return UserModel(userId: json['userId'],id: json['id'],title: json['title'],body: json['body']);
  }
}