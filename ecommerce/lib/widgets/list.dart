import 'dart:io';
import 'package:ecommerce/routes.dart';
import 'package:ecommerce/screens/cart_screen.dart';
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

  // Exemplo de lista de produtos no carrinho

  _onAddToCart(Map<String, dynamic> product) {
    setState(() {
      // Verifica se o produto já está no carrinho
      var existingProduct = cart_cat.firstWhere(
        (item) => item['id'] == product['id'],
        orElse: () => <String, dynamic>{},
      );

      if (existingProduct.isNotEmpty) {
        // Se o produto já está no carrinho, aumenta a quantidade
        existingProduct['quantity'] += 1;
      } else {
        // Se o produto não está no carrinho, adiciona-o com quantidade inicial de 1
        var newProduct = Map<String, dynamic>.from(product);
        newProduct['quantity'] = 1; // Define quantidade inicial
        cart_cat.add(newProduct);
      }

      isAddedToCart = true;
    });

    // Exibe o SnackBar
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Column(
            children: [
              Text('${product['nameProd']} adicionado ao carrinho!'),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, AppRoutes.CART,
                      arguments: cart_cat);
                },
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "Ver carrinho",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });

    // Iniciar animação
    _controller.forward().then((_) {
      _controller.reverse();
    });
  }

  void _navigateToCartScreen() async {
    var updatedCartItems = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(),
        settings:
            RouteSettings(arguments: cart_cat), // Passa os itens do carrinho
      ),
    );

    // Verifica se a lista foi atualizada e atualiza o estado da tela inicial
    if (updatedCartItems != null) {
      setState(() {
        cart_cat =
            updatedCartItems; // Atualiza a lista de produtos com os itens do carrinho
      });
    }
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
        width: 170,
        child: Card(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagem do produto
              Container(
                height: 100,
                width: 180,
                child: info['image'] != null
                    ? Image.network(
                        info['image']!,
                        fit: BoxFit.fitHeight,
                        headers: {
                          HttpHeaders.authorizationHeader: 'Basic $auth'
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(child: CircularProgressIndicator());
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Center(child: Text("Failed to load image"));
                        },
                      )
                    : Center(child: Text("No Image Available")),
              ),
              const SizedBox(height: 10),

              // Preço do produto
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

              // Nome do produto
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

              // Botão de adicionar ao carrinho
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: double.infinity, // Full width of the container
                  child: ScaleTransition(
                    scale: _animation.drive(Tween(begin: 0.8, end: 1.0)),
                    child: ElevatedButton(
                      onPressed: () {
                        _onAddToCart(info);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        backgroundColor:
                            isAddedToCart ? Colors.green : Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        isAddedToCart ? "Adicionado" : "Adicionar",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black), // Increased font size
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
    final format =
        NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$', decimalDigits: 2);
    return format.format(amount);
  }
}
