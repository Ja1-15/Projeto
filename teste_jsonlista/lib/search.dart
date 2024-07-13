import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teste_jsonlista/post.dart';
import 'package:teste_jsonlista/routes/app_routes.dart';


class CustomSearchDelegate extends SearchDelegate{
 
  final Users _future = Users();

  @override
  List<Widget> buildActions(BuildContext context){
    return[
      IconButton(onPressed: (){
        query = '';
      }, icon: const Icon(Icons.clear))
    ];
  }
  
  @override
  Widget buildLeading(BuildContext context) {
   return IconButton(onPressed: (){
    Navigator.pop(context);
   }, icon: const Icon(Icons.arrow_back));
  }
  
  @override
  Widget buildResults(BuildContext context) {
      return Container(
        child: FutureBuilder<List<Post>>(
          future: _future.getUser(query: query),
          builder: (context, snapshot) {
            if(snapshot.hasData == true){
              const CircularProgressIndicator();
            //UserTile
              return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, index){
                if(index<snapshot.data!.length){
                List<Post>? data = snapshot.data;
                const avatar = CircleAvatar(child: Icon(Icons.person));
                return ListTile(
                  onTap: (){
                    Navigator.of(context).pushNamed(AppRoutes.USER_EDIT, arguments: data[index]);
                  },
                  leading: avatar,
                  title: Text(data![index].nome.toString(),
                  ),
                  subtitle: Text(data[index].email.toString()),
                );
              }
                return null;
              
              },   
              );
            }
            else{
                return const Center(child: CircularProgressIndicator());
              }
            
            
               
}));}

  @override
  Widget buildSuggestions(BuildContext context) {
    return  const Center(
        child: Text("Procurar nome"),
      ) ;
  }
  }


class Users {
  List<Post> list = [];
  Future<List<Post>> getUser({String? query})async {
  list.clear();
  final url = Uri.parse("SUA_API");
    final response = await http.get(url);
    var responseJson = json.decode(response.body);
    final List body = responseJson['data'];
    final List<Post> newBody = body.map((e) => Post.fromJson(e)).toList();
    list.addAll(newBody);
    return list;
  }
}