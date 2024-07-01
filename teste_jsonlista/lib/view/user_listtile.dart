import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:teste_jsonlista/post.dart';
import 'package:teste_jsonlista/routes/app_routes.dart';
import 'package:dio/dio.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  _UserListState createState() =>  _UserListState();

}
class _UserListState  extends State<UserList>{
  final controller = ScrollController();
  final dio = Dio();
  bool hasmore = false;
  bool isloading = true;
  int page = 1;

  List<Post> lista = [];  

  @override
  void initState() {
    super.initState();
    getPosts();    
    controller.addListener(loadMoreData);
    }
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> getPosts() async {
    int pagesize = 10;
    var url = Uri.parse("http://154.12.241.153:28888/customers?pageSize=$pagesize&page=$page&search=teste");
    final response = await http.get(url);
    var responseJson = json.decode(response.body);
    final List body = responseJson['data'];
    final List<Post> new_body = body.map((e) => Post.fromJson(e)).toList();
    setState(() {
      lista.addAll(new_body);
      hasmore = false;
    });
  }
    void loadMoreData(){
      if (controller.position.pixels == controller.position.maxScrollExtent) {
        page++;
        getPosts();
        hasmore = true;
      }   
    }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Usuarios'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.USER_FORM);
              },
              )

        ],
      ),
      body: RefreshIndicator(
        onRefresh: (){
          Navigator.pushReplacement(
          context, 
          PageRouteBuilder(pageBuilder: ( a, b, c) => UserList(),
          transitionDuration: Duration(seconds: 3)));
          return Future.value(false);
        },
        child: Center(
          //UserTile
          child: ListView.builder(
            controller: controller,
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: false,
        itemCount: lista.length + 1,
        itemBuilder: (context, index) {
          if(index<lista.length ){
          final post = lista[index];
          final avatar = const CircleAvatar(child: Icon(Icons.person));
          return ListTile(
            leading: avatar,
            title: Text(post.nome!),
            subtitle: Text(post.email!),
            trailing: SizedBox(
          width: 100,
          child: Row(
            children: <Widget>[
              IconButton(
                  icon: const Icon(Icons.edit),
                  color: Colors.orange,
                  onPressed: () {
                    Navigator.of(context).pushNamed(AppRoutes.USER_FORM, arguments: post);
                  }),
                  IconButton(
                  icon: const Icon(Icons.delete), color: Colors.red, onPressed: () {
                    showDialog(context: context, builder: (ctx) => AlertDialog(
                      title: const Text("Excluir Usuário"),
                      content: const Text("Tem certeza?"),
                      actions: <Widget>[
                        TextButton(child: const Text("Não"), onPressed: () {Navigator.of(context).pop();}, ),
                        TextButton( child: const Text("Sim"), onPressed: () {
                          deleteData(index);
                          Navigator.of(context).pop();
                          getPosts();
                         },)
                      ],
                    ));
                  })
            ]
          )
            )
          );
        }
         else{
          return  Padding(padding: const EdgeInsets.symmetric(vertical: 32),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: hasmore ? const SpinKitThreeBounce(color: Color.fromARGB(255, 144, 25, 212), size: 40,): Text("No more Data")));
        }},   
        ),
            ),
      ));
  }
  deleteData(int index) async{
        final post = lista[index];
        final deletar = post.id;
        Uri uri = Uri.parse("http://154.12.241.153:28888/customers/$deletar") ;
        final response = await http.delete(uri);
        if(response.statusCode == 200){
        build(context);
      }

}
}