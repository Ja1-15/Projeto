import 'dart:io';
import 'package:ecommerce/routes.dart';
import 'package:ecommerce/screens/categories_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

String auth = "NllIUFNURUU4SkRTM0VIQ1NYU0c3QlE1QTU1QUxKSkE6";

// ignore: must_be_immutable
class Lista_produtos extends StatefulWidget {
  var info;
  Lista_produtos({super.key, required this.info});

  @override
  State<Lista_produtos> createState() => _Lista_produtosState();
}

class _Lista_produtosState extends State<Lista_produtos>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool isAddedToCart = false;
  int quantity = 1;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showAddToCartModal(
      BuildContext context, Map<String, dynamic> product) async {
    int quantity = 1; // Set a default quantity

    final result = await showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, modalSetState) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 100,
                    width: 180,
                    child: product['image'] != null
                        ? Image.network(
                            product['image']!,
                            fit: BoxFit.fitHeight,
                            headers: {
                              HttpHeaders.authorizationHeader: 'Basic $auth'
                            },
                          )
                        : Center(child: Text("No Image Available")),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    product['nameProd'] ?? 'No Name',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '${formatCurrencyBRL(double.parse(product['price'].toString().replaceAll("R\$ ", '')))}',
                    style: TextStyle(fontSize: 18, color: Colors.green),
                  ),
                  SizedBox(height: 20),

                  // Quantity selection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          if (quantity > 1) {
                            modalSetState(() {
                              quantity--;
                            });
                          }
                        },
                      ),
                      Text(
                        '$quantity',
                        style: TextStyle(fontSize: 18),
                      ),
                      IconButton(
                        icon: Icon(Icons.add_circle_outline),
                        onPressed: () {
                          modalSetState(() {
                            quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: () {
                      _onAddToCart(product, quantity);
                      Navigator.pop(context, true);
                    },
                    style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        minimumSize: Size(double.infinity, 60)),
                    child: Text(
                      '$quantity x ${formatCurrencyBRL(quantity * double.parse(product['price'].toString().replaceAll("R\$ ", '')))}',
                      style: TextStyle(fontSize: 18, color: Colors.black),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );

    // If the result is true, show the SnackBar on the home page
    if (result == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${product['nameProd']} adicionado ao carrinho!'),
          action: SnackBarAction(
            label: 'Ver carrinho',
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.CART, arguments: cart_cat);
            },
          ),
        ),
      );
    }
  }

  _onAddToCart(Map<String, dynamic> product, int quantity) {
    setState(() {
      var existingProduct = cart_cat.firstWhere(
        (item) => item['id'] == product['id'],
        orElse: () => <String, dynamic>{},
      );

      if (existingProduct.isNotEmpty) {
        existingProduct['quantity'] += quantity;
      } else {
        var newProduct = Map<String, dynamic>.from(product);
        newProduct['quantity'] = quantity;
        cart_cat.add(newProduct);
      }

      isAddedToCart = true;
    });

    _controller.forward().then((_) {
      _controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildProductCard(widget.info!);
  }

  Widget buildProductCard(Map<String, dynamic> info) {
    var rep = info['price'].toString().replaceAll("R\$ ", '');
    var amount = formatCurrencyBRL(double.parse(rep));

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, AppRoutes.PRODUCTS, arguments: info);
      },
      child: SizedBox(
        height: 300,
        width: 180,
        child: Card(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 90,
                width: 190,
                child: info['image'] != null
                    ? Image.network(
                        info['image']!,
                        fit: BoxFit.fitHeight,
                        headers: {
                          HttpHeaders.authorizationHeader: 'Basic $auth'
                        },
                      )
                    : Center(child: Text("No Image Available")),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  amount.toString(),
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromARGB(255, 21, 202, 36),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  info['nameProd'] ?? 'No Name',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: ScaleTransition(
                    scale: _animation.drive(Tween(begin: 0.8, end: 1.0)),
                    child: ElevatedButton(
                      onPressed: () {
                        _showAddToCartModal(context, info);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        "Adicionar",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  String formatCurrencyBRL(double amount) {
    final format = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
      decimalDigits: 2,
    );
    return format.format(amount);
  }
}
