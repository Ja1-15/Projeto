import 'package:api_teste/models/Post.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
 
Future getUser() async {
   List<Post> users = [];
    var response = await http.get(Uri.https('dummyjson.com', '/user')
    );
    var jsonData = jsonDecode(response.body);
  for (var eachUser in jsonData()) {
        final user = Post(
            id: eachUser['id'],
            firstName: eachUser['firstName'],
            lastName: eachUser['lastName'],
            email: eachUser['email'],
            image: eachUser['image']);
        users.add(user);
      }
    print(users);
    }
@override 
Scaffold build(BuildContext context){
  var init = getUser();
  return Scaffold(
    body: Text("Olá"),
    backgroundColor: Colors.black,

  );
}


}