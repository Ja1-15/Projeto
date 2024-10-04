import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecommerce/routes.dart';
import 'package:ecommerce/screens/categories_screen.dart';
import 'package:ecommerce/screens/products_screen.dart';
import 'package:ecommerce/widgets/list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

String url_base = "https://b2b.redemachado.com.br";
String auth = "NllIUFNURUU4SkRTM0VIQ1NYU0c3QlE1QTU1QUxKSkE6";
var banner_link = [];

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late Future<List> _future;

  int current = 0;
  List lista = [];
  List lista_prod = [];
  final dropValue = ValueNotifier('');
  List lista_bloco = [];
  var imagem;
  List categorias = [];
  int cartItemCount = 0;

  @override
  void initState() {
    super.initState();
    _future = getdata();
  }

  Future<List> getdata() async {
    final temporaryList = [];

    // Fetching data from API
    var uri = Uri.parse(
        "https://b2b.redemachado.com.br/api/mobikul/gethomepage?width=720&ws_key=6YHPSTEE8JDS3EHCSXSG7BQ5A55ALJJA&id_lang=2");
    var response = await http.get(uri);
    final document = xml.XmlDocument.parse(response.body);
    final prestashop = document.findElements('prestashop').first;

    // Parsing banners
    final banners = prestashop.findElements('banners').first;
    final banner = banners.findElements('banner');
    banner_link.clear();
    for (var link in banner) {
      final image_link = link.findElements('image_link').first.text;
      banner_link.add(image_link);
    }

    // Parsing product blocks and products
    final product_block = prestashop.findElements('product_block').first;
    final blocks = product_block.findElements('block');
    lista_bloco.clear();
    for (final block in blocks) {
      final title = block.findElements('title').first.text;
      lista_bloco.add({'block': title});
      final products = block.findElements('products').first;
      final product = products.findElements('product');
      for (final prod in product) {
        final nameProd = prod.findElements('name').first.text;
        final price = prod.findAllElements('price').first.text;
        final image = prod.findAllElements('image_link').first.text;
        temporaryList.add({
          'block': title,
          'nameProd': nameProd,
          'price': price,
          'image': image
        });
      }
    }

    // Fetching categories
    var uri3 = Uri.parse(
        'https://b2b.redemachado.com.br/api/categories/?filter[id_parent]=2');
    var response2 = await http
        .get(uri3, headers: {HttpHeaders.authorizationHeader: 'Basic $auth'});
    final document3 = xml.XmlDocument.parse(response2.body);
    final prestashop3 = document3.findElements('prestashop').first;
    final categories = prestashop3.findElements('categories').first;
    final category = categories.findAllElements('category');
    categorias.clear();
    for (var cat in category) {
      final link_category = cat.getAttribute('xlink:href');
      var uri2 = Uri.parse(link_category.toString());
      var response2 = await http
          .get(uri2, headers: {HttpHeaders.authorizationHeader: 'Basic $auth'});
      final document2 = xml.XmlDocument.parse(response2.body);
      final prestashop2 = document2.findElements('prestashop').first;
      final categoria = prestashop2.findElements('category').first;
      final name = categoria.findElements('name').first.text;
      final idcategoria_parent = categoria.findElements('id').first.text;
      categorias.addAll([
        {'name': name, 'id': idcategoria_parent}
      ]);
    }

    lista = temporaryList;
    return lista;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        title: Text(
          "Nome do Perfil",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.LOGIN);
            },
            icon: Icon(CupertinoIcons.person_fill)),
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<List>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      buildImage(),
                      SizedBox(height: 20),
                      buildTabs(),
                      ...buildProductBlocks(),
                      SizedBox(height: 30),
                      buildImage(),
                    ],
                  ),
                ),
              );
            } else {
              return Center(child: Text("No data available"));
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var filteredCart = cart_cat.where((item) {
            // Example filter conditions
            return item['nameProd'] != null &&
                item['nameProd'].isNotEmpty &&
                item['price'] != null &&
                item['price'].isNotEmpty;
          }).toList();
          print(filteredCart);
          // Navigate with the filtered cart items
          Navigator.pushNamed(context, AppRoutes.CART, arguments: filteredCart);
        },
        backgroundColor: Colors.white,
        child: Icon(Icons.shopping_cart),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget buildImage() {
    return Container(
      height: 170,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: CarouselSlider(
        options: CarouselOptions(autoPlay: true),
        items: banner_link.map((item) {
          return Center(
            child: Image.network(
              item,
              fit: BoxFit.cover,
              width: 1000,
              height: 170,
            ),
          );
        }).toList(),
      ),
    );
  }

  List<Widget> buildProductBlocks() {
    return List<Widget>.generate(lista_bloco.length, (index) {
      return Column(
        children: [
          SizedBox(height: 20),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              lista_bloco[index]['block'],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 250,
            child: buildMainList(lista_bloco[index]['block']),
          ),
        ],
      );
    });
  }

  Widget buildMainList(String condition) {
    return ListView.builder(
      itemCount: lista.length,
      scrollDirection: Axis.horizontal,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        Map<String, dynamic>? info2 = lista[index];
        if (lista[index]['block'].contains(condition)) {
          return Lista_produtos(
            info: info2,
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget buildTabs() {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: categorias.length,
        itemBuilder: (context, index) {
          return FittedBox(
            child: InkWell(
              onTap: () {
                setState(() {
                  current = index;
                });
                Navigator.of(context).pushNamed(AppRoutes.CATEGORIES,
                    arguments: categorias[index]['id']);
              },
              child: Container(
                height: 40,
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.black12.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    categorias[index]['name'],
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
