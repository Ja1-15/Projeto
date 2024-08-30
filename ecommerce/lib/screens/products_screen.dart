import 'dart:convert';
import 'package:ecommerce/models/categorias.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;  
  late Future<List<Categorias>?> _future;
  var index;


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this );
  }

  
     
  @override
  Widget build(BuildContext context) {
    final id_p = ModalRoute.of(context)!.settings.arguments;
    _future = get_cat(id_p.toString());
        return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          leading: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back),
          ),
          title: Text("Produtos", style: TextStyle(
            fontFamily: 'Varela', fontSize: 20, color: Color(0xFF545D68),
          ),),
          actions: <Widget>[
            IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none))
          ],
        ),
        body:
          FutureBuilder<List<Categorias>?>(
            future: _future,
            builder: (context, snapshot){           
               final posts = snapshot.data!;
               return build_cards(posts);                  
            }
            
          )
          
        );
    
  }
  Widget build_cards(List<Categorias> posts){

   return GridView.builder( 
   itemCount: posts.length,
   itemBuilder: (context, index) {
    final post = posts[index];
          return InkWell(
                    onTap: (){},
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: Card(
                                  child: Container(
                                    height: 160,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        ),
                                    margin: EdgeInsets.all(5),
                                    padding: EdgeInsets.all(5),
                                    child: Stack(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              child: Image.asset(
                                                "images/hortifruti.jpg",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            Text(
                                              post.name.toString(),
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  );
   }, 
   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
   crossAxisCount: 2,
   mainAxisSpacing: 5,
   crossAxisSpacing: 5),
   );
  }
   Future<List<Categorias>?> get_cat(String? id_p)async{
     
      
  }
          
}