import 'dart:collection';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/screens/product_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;



var lista = [];
var banner_link = [];
var lista_bloco =[];
String url_base = "https://b2b.redemachado.com.br";

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
    var _future;

  @override
  void initState() {
  super.initState();
    _future = getdata();
  }

  Future<List> getdata() async {
   
    var uri = Uri.parse("https://b2b.redemachado.com.br/api/mobikul/gethomepage?width=720&ws_key=6YHPSTEE8JDS3EHCSXSG7BQ5A55ALJJA&id_lang=2");
    var response = await http.get(uri);
    final temporaryList = [] ;
//
    final document = xml.XmlDocument.parse(response.body);
    final prestashop = document.findElements('prestashop').first;
    final banners = prestashop.findElements('banners').first;
    final banner = banners.findElements('banner');

// 
      for (var link in banner){
      final image_link = link.findElements('image_link').first.text;
      final id_page = link.findElements('id_page').first.text;

      banner_link.add(image_link); 
      }   

///

    final document2 = xml.XmlDocument.parse(response.body);
    final prestashop2 = document2.findElements('prestashop').first;
    final product_block = prestashop2.findElements('product_block').first;
    final blocks = product_block.findElements('block');

// 
    for (final block in blocks) {

      final id = block.findElements('id_product_block').first.text;
      final title = block.findElements('title').first.text;

      lista_bloco.addAll([{'block': title}]);

    
      /// produtos
      final products = block.findElements('products').first;
      final product = products.findElements('product');

      for (final prod in product) {

        final idProd = prod.findElements('id_product').first.text;
        final nameProd = prod.findElements('name').first.text;
        final price = prod.findAllElements('price').first.text;
        final image = prod.findAllElements('image_link').first.text;
        
     temporaryList.addAll([{'block' : title, 'id_block': id, 'name_prod': nameProd, 'price' : price, 'id_prod': idProd, 'image_prod': image }]);

      }
      
    }
    
    ///
    setState(() {
      lista = temporaryList;
    });

    return lista;
  }

  List tabs = [];

final List<Widget> imageSliders = banner_link
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        child: Text(
                          'No. ${banner_link.indexOf(item)} image',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();


  @override
  Widget build(BuildContext context) {
    int i;
    i = 0; 
    return Scaffold(
      appBar: AppBar(
        title: Align(alignment: Alignment.center, child: Text("Home Screen")),
      ),
      body: 
         FutureBuilder<List>(
          future: _future,
           builder: (context,snapshot) {
             if(snapshot.hasData == true){
             return SingleChildScrollView(
              child: SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(left: 15, right: 15, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: EdgeInsets.all(5),
                            height: 50,
                            width: MediaQuery.of(context).size.width - 30,
                            decoration: BoxDecoration(                      
                              color: Colors.black12.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.search,
                                  color: Color(0xFFEF6969),),
                                  border: InputBorder.none,
                                  label: Text("Find your product",
                                  style: TextStyle(),),
                                ),
                              ),    
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
                      buildImage(),
                      SizedBox(height: 20),
                      buildTabs(),
                      SizedBox(height: 20,),
                      Align(alignment: Alignment.centerLeft,child: Text(lista_bloco[i]['block'], style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)),
                      buildList(lista_bloco[i++]['block']),
                      SizedBox(height: 20,),
                      buildImage(),
                      SizedBox(height: 20),
                      Align(alignment: Alignment.centerLeft,child: Text(lista_bloco[i]['block'], style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),)),
                      buildList(lista_bloco[i]['block'])
                    ],
                  ),
                ),
              ),
                     );
           }
           else{
            return Align(alignment: Alignment.center, child: CircularProgressIndicator());
           }
           }
         )
    );
      }
      Widget buildImage(){
       return Container(
                    height: 70,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                      ),
                      items: banner_link
                          .map((item) => Container(
                                child: Center(
                                    child:
                                        Image.network(item.toString(), fit: BoxFit.cover, width: 1000, height: 70,)),
                              ))
                          .toList(),
                          ),
                  );
      }

       buildList(String condition){
          return  Container(
                    height: 250,
                    child: ListView.builder(
                      itemCount: lista.length,
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder:(context, index){
                          if(lista[index]['block'].contains(condition)){
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
                                  child: Image.network(lista[index]["image_prod"]),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  width: 180,
                                  height: 50,
                                  child: Text(lista[index]['name_prod'],
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                ),
                                    Container(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(lista[index]["price"],
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
                      }
                      else{
                        return Container();
                      }
                        
      }),
                  );
        }
      Widget buildTabs(){
        return SizedBox(
                    height: 50,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: tabs.length,
                      itemBuilder: (context, index) {
                      return  FittedBox(
                        child: Container(
                          height: 40,
                          margin: EdgeInsets.all(8.0),
                          padding: EdgeInsets.only(left: 15, right: 15),
                          decoration: BoxDecoration(
                            color: Colors.black12.withOpacity(0.05),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: FittedBox(
                              child: Text(tabs[index],
                              style: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),),
                            ),
                          ),
                        ),
                      );
                    } ),
                  );
      }

}
        
        