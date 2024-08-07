import 'dart:convert';
import 'package:ecommerce/models/categorias.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:prestashop_api/prestashop_api.dart';

String prettyJson<T>({
  String? tagText,
  required dynamic data,
  required Map<String, dynamic> Function(T, bool) toJsonMap,
  bool keepEmptyFields = false,
}) {
  final object = data is List
      ? (data as List<T>)
      .map((item) => toJsonMap(item, keepEmptyFields))
      .toList()
      : toJsonMap(data as T, keepEmptyFields);

  final prettyPrinted = const JsonEncoder.withIndent('  ').convert(object);

  return prettyPrinted;

}


class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;  
  late Future<List<Categoria>?> _future;
  var index;
  final logger = Logger();

  final prestashop = PrestashopApi(
    BaseConfig(
      baseUrl: "b2b.redemachado.com.br",
      apiKey: "6YHPSTEE8JDS3EHCSXSG7BQ5A55ALJJA",
      protocol: Protocol.https,
    ),
  );



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
          FutureBuilder<List<Categoria>?>(
            future: _future,
            builder: (context, snapshot){           
               final posts = snapshot.data!;
               return build_cards(posts);                  
            }
            
          )
          
        );
    
  }
  Widget build_cards(List<Categoria> posts){

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
   Future<List<Categoria>?> get_cat(String? id_p)async{
     final receivedCategories = await prestashop.getCategories(
      languageId: 2,
      filter: Filter.anyOf(CategoryFilterField.idParent, values: ['$id_p']),
      display: const Display(
        displayFieldList: [
          CategoryDisplayField.all
        ],
      ),
      sort: Sort(
        sortFieldOrderList: [SortFieldOrder.ascending(CategorySortField.description)],
      ),
    );
     var data = prettyJson<Category>(
        tagText: 'Categories',
        data: receivedCategories.entity,
        toJsonMap: categoryToJsonMap,
      );

      List body = json.decode(data);

      return body.map((e) => Categoria.fromJson(e)).toList();
      
  }
          
}