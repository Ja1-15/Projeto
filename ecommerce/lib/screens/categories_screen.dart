import 'dart:convert';
import 'package:ecommerce/models/categorias.dart';
import 'package:ecommerce/routes.dart';
import 'package:ecommerce/screens/product_view_screen.dart';
import 'package:flutter/material.dart';
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
List xml = []; 

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;  
  var _future;
  var index;
  @override
  void initState() {
    super.initState();
    _future = get_cat('2');
  }

  final prestashop = PrestashopApi(
    BaseConfig(
      baseUrl: "b2b.redemachado.com.br",
      apiKey: "6YHPSTEE8JDS3EHCSXSG7BQ5A55ALJJA",
      protocol: Protocol.https,
    ),
  );

  Future<void> get_cat(String? id)async{
     final receivedCategories = await prestashop.getCategories(
      languageId: 2,
      filter: Filter.anyOf(CategoryFilterField.idParent, values: ['$id']),
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
      body.map((e) => Categoria.fromJson(e)).toList();


      return xml.addAll(body); 
      
  }

     
  @override
  Widget build(BuildContext context) { 
        return Scaffold(
          backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          title: Text("Categories", style: TextStyle(
            fontFamily: 'Varela', fontSize: 20, color: Color(0xFF545D68),
          ),),
          actions: <Widget>[
            IconButton(onPressed: (){}, icon: Icon(Icons.notifications_none))
          ],
        ),
        body:
          FutureBuilder(
            future: _future,
            builder: (context, snapshot){           
               if(snapshot.hasData == true){         
               final posts = snapshot.data;
               return build_cards(posts as List<Categoria>?);  
              }
              else{
                return Align(alignment: Alignment.center,child: CircularProgressIndicator());
              }                    
            }
            
          )
          
        );
    
  }
  Widget build_cards(List<Categoria>? posts){
   return Column(
     children: [
      SizedBox(height: 15,),
       TextFormField(
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search,
              color: Color(0xFFEF6969),),
              border: InputBorder.none,
              label: Text("Procurar produto",
              style: TextStyle(),),
              ),
         ),
         SizedBox(height: 30,),
         Align(
                    alignment: Alignment.topLeft,
                    child: Text("Categorias",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500
                    ),),
                  ),
       SizedBox(height: 15,),
       Container(
        height: 90,
         child: ListView.builder(
                itemCount: posts?.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index){
                final post = posts?[index];
                return Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 15),
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Image(image: AssetImage("images/store_icon.png")),
                            ),
                    ),
                    Container(
                      width: 80,
                      child: Text(post!.name.toString(),style: TextStyle(
                        overflow: TextOverflow.ellipsis
                      ),),
                    )
                  ],
                );
                        }
                        
                        ),
       ),
     ],
   );
              
          
  }
  }           