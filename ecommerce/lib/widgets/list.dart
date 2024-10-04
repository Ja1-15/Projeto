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
  bool isAdded = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse(); // Return to normal after scaling up
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onAddtoCart() {
    setState(() {
      isAdded = !isAdded;
    });
    _controller.forward();
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
              // Product image
              Container(
                height: 100,
                width: 170,
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

              // Product price
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
              // Product name
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  info['nameProd'] ?? 'No Name',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                ),
              ),
              const SizedBox(height: 5),
              const Spacer(),
              // Add to cart button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      cart_cat.addAll({info});
                    },
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.green),
                    ),
                    child: Text(
                      'Adicionar',
                      style: TextStyle(
                        color: Colors.black,
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
}

String formatCurrencyBRL(double amount) {
  final format =
      NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$', decimalDigits: 2);
  return format.format(amount);
}
