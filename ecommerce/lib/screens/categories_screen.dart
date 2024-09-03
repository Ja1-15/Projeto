
import 'dart:io';
import 'package:ecommerce/screens/product_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

var lista_prod = [];
var category_name = [];

String auth = "NllIUFNURUU4SkRTM0VIQ1NYU0c3QlE1QTU1QUxKSkE6";


class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

  @override
  Widget build(BuildContext context) {
    lista_prod.clear();
    var id_categoria = ModalRoute.of(context)!.settings.arguments;
    var _future = getData(id_categoria.toString());
    
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if(snapshot.hasData == true){
        return Scaffold(
        appBar: AppBar(title: Text("Título", style: TextStyle(fontWeight: FontWeight.bold),),
        automaticallyImplyLeading: false,),
        body: ListView.builder(
            itemCount: 1 ,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index){ 
             
              return Column(
              children: [
                  SizedBox(height: 20,),
                    Container(
                          height: 250,
                          child: ListView.builder(
                            itemCount: lista_prod.length,
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemBuilder:(context, index){
                                return InkWell(
                                onTap: (){
                                   Navigator.push(context, MaterialPageRoute(builder: (context) => ProductScreen()));
                                },
                                child: Card(
                                  color: Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 150,
                                        width: 180,
                                        child: Image.network(lista_prod[index]["image_prod"], headers: { HttpHeaders.authorizationHeader : 'Basic $auth'},),
                                      ),
                                      SizedBox(height: 10,),
                                      Container(
                                        padding: EdgeInsets.only(left: 10),
                                        width: 180,
                                        height: 50,
                                        child: Text(lista_prod[index]['name_prod'],
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),),
                                      ),
                                          Container(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(lista_prod[index]["price"],
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: const Color.fromARGB(255, 23, 161, 25),
                                              fontWeight: FontWeight.bold,                              
                                            ),),
                                          ),                            
                                    ],
                                  ),
                                ),
                              );
                           
                              
                      }),
                        ),
              ],
            );

            }
          ),
      );
  }
  else{
    return Scaffold(
      body: Align(alignment: Alignment.center,child: CircularProgressIndicator()),
    );
  }
  }
  );
  }
  getData(String id_parent)async{
  var temporaryList = [];
  
  var uri = Uri.parse('https://b2b.redemachado.com.br/api/categories/?filter[id_parent]=$id_parent');
  var response = await http.get(uri, headers: {HttpHeaders.authorizationHeader: 'Basic $auth'});
  final document = xml.XmlDocument.parse(response.body);
  final prestashop = document.findElements('prestashop').first;
  final categories = prestashop.findElements('categories').first;
  var categ = categories.findAllElements('category');

  for(final cg in categ){
    var id = cg.getAttribute('id');
    var uri2 = Uri.parse('https://b2b.redemachado.com.br/api/categories/?filter[id_parent]=$id');
    var response2 = await http.get(uri2, headers: {HttpHeaders.authorizationHeader : 'Basic $auth'});
    final document2 = xml.XmlDocument.parse(response2.body);
    final prestashop2 = document2.findElements('prestashop').first;
    final categories2 = prestashop2.findElements('categories').first;
    final c = categories2.findElements('category');
    
    for(final cat in c){
      var id_cat = cat.getAttribute('id');
      var uri3 = Uri.parse('https://b2b.redemachado.com.br/api/categories/$id_cat');
      var response3 = await http.get(uri3, headers: {HttpHeaders.authorizationHeader : 'Basic $auth'});
      final document3 = xml.XmlDocument.parse(response3.body);
      final prestashop3= document3.findElements('prestashop').first;
      final category3 = prestashop3.findElements('category').first;
      final name2 = category3.findAllElements('name');
      final associations2 = category3.findElements('associations').first;
      final products2 = associations2.findElements('products').first;
      final product2 = products2.findAllElements('product');
    
      for(final prod in product2){
          var link2 = prod.getAttribute('xlink:href');
          var uri4 = Uri.parse(link2.toString());
          var response4 = await http.get(uri4, headers: {HttpHeaders.authorizationHeader: 'Basic $auth'});
          final document = xml.XmlDocument.parse(response4.body);
          final prestashop = document.findElements('prestashop').first;
          final product = prestashop.findElements('product').first;
          final idProd = product.findElements('id').first.text;
          final nameProd = product.findElements('name').first.text;
          final price = product.findAllElements('price').first.text;
          final associations3 = product.findElements('associations').first;
          final images = associations3.findAllElements('images').first;
          if(images.childElements.isEmpty == false){
          final image = images.findElements('image').first;
          final link_image = image.getAttribute('xlink:href').toString();
                              
          temporaryList.addAll([{ 'id': idProd, 'name_prod': nameProd, 'price' : price, 'id_prod': idProd, 'image_prod': link_image }]);
           }
          else{
          temporaryList.addAll([{ 'id': idProd, 'name_prod': nameProd, 'price' : price, 'id_prod': idProd, 'image_prod': 'No Data' }]);
           }
           }
        lista_prod = temporaryList;            
      }
    }  
    print(category_name);  
    return lista_prod;   
  }                         
}