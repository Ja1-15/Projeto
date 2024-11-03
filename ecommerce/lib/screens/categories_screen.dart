import 'dart:io';
import 'package:ecommerce/routes.dart';
import 'package:ecommerce/widgets/cart_button.dart';
import 'package:ecommerce/widgets/list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

String auth = "NllIUFNURUU4SkRTM0VIQ1NYU0c3QlE1QTU1QUxKSkE6";
List lista_nome = [];
List lista_product = [];
List selected_products = [];
List<Map<String, dynamic>> cart_cat = [{}];
var current = 0;
var imagem;

class CategoryDropDown extends StatelessWidget {
  const CategoryDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    var id_parent = ModalRoute.of(context)!.settings.arguments;
    var _future = subcat(id_parent.toString());
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 247, 247),
      appBar: AppBar(
        title: const Text('Produtos'),
        backgroundColor: Color.fromARGB(255, 248, 247, 247),
        surfaceTintColor: Color.fromARGB(255, 248, 247, 247),
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.HOME);
            },
            icon: Icon(Icons.arrow_back)),
        elevation: 0,
      ),
      body: FutureBuilder(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.hasData == true) {
              return ListView.builder(
                  itemCount: lista_nome.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              lista_nome[index]['name'],
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                            height: 250,
                            child: build_list(lista_nome[index]['id_cat'])),
                      ],
                    );
                  });
            } else {
              return Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              );
            }
          }),
      floatingActionButton: CartButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}

subcat(String id_categoria) async {
  final temporaryList2 = [];
  final temporaryList3 = [];

  var uri4 = Uri.parse(
      'https://b2b.redemachado.com.br/api/categories/?filter[id_parent]=$id_categoria');
  var response4 = await http
      .get(uri4, headers: {HttpHeaders.authorizationHeader: 'Basic $auth'});
  final document3 = xml.XmlDocument.parse(response4.body);
  final prestashop3 = document3.findElements('prestashop').first;
  final categories = prestashop3.findAllElements('categories').first;
  final category = categories.findAllElements('category');

  for (var cat in category) {
    final link_category = cat.getAttribute('xlink:href');
    var uri2 = Uri.parse(link_category.toString());
    var response2 = await http
        .get(uri2, headers: {HttpHeaders.authorizationHeader: 'Basic $auth'});
    final document2 = xml.XmlDocument.parse(response2.body);
    final prestashop2 = document2.findElements('prestashop').first;
    final categoria = prestashop2.findElements('category').first;
    final products = categoria.findAllElements('products').first;
    final product = products.findAllElements('product');
    final categories = categoria.findAllElements('categories').first;
    final category = categories.findAllElements('category');
    for (var cat in category) {
      final l = cat.getAttribute('xlink:href');
      var uri5 = Uri.parse(l.toString());
      final response5 = await http
          .get(uri5, headers: {HttpHeaders.authorizationHeader: 'Basic $auth'});
      final document5 = xml.XmlDocument.parse(response5.body);
      final prestashop5 = document5.findElements('prestashop').first;
      final category = prestashop5.findElements('category').first;
      final name = category.findElements('name').first.text;
      final id_cat = cat.findElements('id').first.text;

      temporaryList2.addAll([
        {'name': name, 'id_cat': id_cat}
      ]);
    }

    for (var pr in product) {
      final link = pr.getAttribute('xlink:href');
      var uri5 = Uri.parse(link.toString());
      var response5 = await http
          .get(uri5, headers: {HttpHeaders.authorizationHeader: 'Basic $auth'});
      final document5 = xml.XmlDocument.parse(response5.body);
      final prestashop5 = document5.findElements('prestashop').first;
      final product = prestashop5.findAllElements('product').first;
      final idPr = product.findElements('id').first.text;
      final namePr = product.findElements('name').first.text;
      final desc = product.findAllElements('description').first.text;
      final pri = product.findAllElements('price').first.text;
      final associations = product.findAllElements('associations').first;
      final categorias = associations.findAllElements('categories').first;
      final category = categorias.findAllElements('category').last;
      var id_parent = category.findElements('id').first.text;
      final imag = associations.findAllElements('images').first;
      if (imag.childElements.isNotEmpty == true) {
        final im = imag.findAllElements('image').first;
        final i = im.getAttribute('xlink:href');
        temporaryList3.addAll([
          {
            'idProduct': idPr,
            'id_category_default': id_parent,
            'nameProd': namePr,
            'description': desc,
            'price': pri,
            'image': i,
            'quantity': "1"
          }
        ]);
      } else {
        temporaryList3.addAll([
          {
            'idProduct': idPr,
            'id_category_default': id_parent,
            'nameProd': namePr,
            'description': desc,
            'price': pri,
            'image': null,
            'quantity': "1"
          }
        ]);
      }
    }
  }
  lista_nome = temporaryList2.toList();
  lista_product = temporaryList3.toList();

  return lista_nome;
}

build_list(String condition) {
  return ListView.builder(
    itemCount: lista_product.length,
    scrollDirection: Axis.horizontal,
    shrinkWrap: true,
    itemBuilder: (context, index) {
      Map<String, String?> info3 = lista_product[index];
      if (info3['id_category_default']!.contains(condition)) {
        return Lista_produtos(info: info3); // Use the new buildProductCard here
      } else {
        return Container(); // Return empty container if condition is not met
      }
    },
  );
}
