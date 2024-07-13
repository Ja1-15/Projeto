import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:teste_jsonlista/post.dart';
import 'package:teste_jsonlista/routes/app_routes.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:teste_jsonlista/search.dart';
import 'package:teste_jsonlista/user_form.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  _UserListState createState() =>  _UserListState();

}
class _UserListState  extends State<UserList>{
  final ScrollController scrollController = ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
  int page = 1;
  late Future<List<Post>> _future;
  bool loading = false;
  List<Post> lista = [];  

  @override
  void initState() {
    super.initState();
    _future = getPosts();
    scrollController.addListener(loadMoreData);
  }
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  loadMoreData(){
    if(scrollController.position.maxScrollExtent == scrollController.position.pixels
   ){
      page++;
      getPosts();
    }
  }

  Future<List<Post>> getPosts() async {
    int pagesize = 10;
    setState(() {
      loading = true;
    });
    var url = Uri.parse("SUA_API");
    final response = await http.get(url);
    var responseJson = json.decode(response.body);
    final List body = responseJson['data'];
    final List<Post> newBody = body.map((e) => Post.fromJson(e)).toList();
    
    
    setState(() {
      lista.addAll(newBody);
    });
    
    return lista;
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Lista de Usuarios'),
        actions: <Widget>[
          IconButton(
              onPressed: (){
                showSearch(
                  context: context,
                  delegate: CustomSearchDelegate(),
                );
              },
              icon: Icon(Icons.search)),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: (){
             Navigator.push(
              context,
               MaterialPageRoute(
                 builder: (context) => UserForm()))
                 .then((value) => setState(() {}));
              },
              ),
            
        ],
      ),
      body: FutureBuilder<List<Post>>(
        future: _future,
        builder: (context, snapshot) {
          if(snapshot.hasData == true){
           return Center(
              //UserTile
              child: ListView.builder(
              controller: scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            shrinkWrap: false,
            itemCount: snapshot.data?.length,
            itemBuilder: (BuildContext context, index){
              if(index<snapshot.data!.length){
              final post = lista[index];
              List<Post>? data = snapshot.data;
              const avatar = CircleAvatar(child: Icon(Icons.person));
              return ListTile(
                leading: avatar,
                title: Text(data![index].nome.toString(),
                ),
                subtitle: Text(data[index].email.toString()),
                trailing: SizedBox(
              width: 100,
              child: Row(
                children: <Widget>[
                  IconButton(
                      icon: const Icon(Icons.edit),
                      color: Colors.orange,
                      onPressed: () {
                        Navigator.of(context).pushNamed(AppRoutes.USER_EDIT, arguments: post);
                      }),
                      IconButton(
                      icon: const Icon(Icons.delete), color: Colors.red, onPressed: () {
                        showDialog(context: context, builder: (ctx) => AlertDialog(
                          title: const Text("Excluir Usuário"),
                          content: const Text("Tem certeza?"),
                          actions: <Widget>[
                            TextButton(child: const Text("Não"), onPressed: () {
                              Navigator.of(context).pop();
                              }, ),
                            TextButton( child: const Text("Sim"), onPressed: () {
                              setState(() {
                                _future = deleteData(index);
                              });
                              Navigator.of(context).pop();
                             },)
                          ],
                        ));
                      })
                ]
              )
                )
              );
            }
            },   
            ),
             
                );}
               if(loading == true){
              return  const Padding(padding: EdgeInsets.symmetric(vertical: 32),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: SpinKitThreeBounce(color: Color.fromARGB(255, 144, 25, 212), size: 40,)));
                }
                else{
                  return const Padding(padding: EdgeInsets.symmetric(vertical: 32),
                  child: Padding(padding: EdgeInsets.all(10),
                  child: Text("No more Data"),),);
                }}
               
      ),);
        }

 Future<List<Post>> deleteData(int index) async{
        final post = lista[index];
        final deletar = post.id;
        ///teste
        Uri uri = Uri.parse("http://154.12.241.153:28888/customers/$deletar") ;
        final response = await http.delete(uri);

    if (response.statusCode == 200) {
    lista.removeAt(index);
    return lista;
  } else {
    throw Exception('Failed to delete album.');
  }
}
  }
 