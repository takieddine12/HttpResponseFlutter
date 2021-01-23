import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'model/UserModel.dart';

void main() => runApp(MyApplication());


class MyApplication extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HOME(),
    );
  }
}
class HOME extends StatefulWidget {
  @override
  _HOMEState createState() => _HOMEState();
}

class _HOMEState extends State<HOME> {

  Future<UserModel> userData;
  @override
  void initState() {
    super.initState();
    userData = getPost();
  }

  Future<UserModel> getPost() async {
     var url = "https://jsonplaceholder.typicode.com/posts/1";
     http.Response postRequest = await http.get(url);
     if(postRequest.statusCode == 200){
        return UserModel.from(json.decode(postRequest.body));
     } else {
        throw Exception("exception happened");
     }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         title: Text("Parsing Json"),
         backgroundColor: Colors.red,
       ),
        body : FutureBuilder<UserModel>(
          future: userData,

          builder: (context,snapshot){
             if(snapshot.hasData){
                 return ListView.builder(
                   itemCount: 20,
                   itemBuilder: (context,i){
                     return ListTile(
                       title: Text(snapshot.data.title),
                       subtitle: Column(
                         children: [
                           Text(snapshot.data.userId.toString()),
                           Text(snapshot.data.id.toString()),
                           Text(snapshot.data.body)
                         ],
                       ),
                     );
                   },
                 );
             } else if(snapshot.hasError){
                 return Text("No data..");
             }
             return CircularProgressIndicator();
          },
        ),
      );
  }
}
