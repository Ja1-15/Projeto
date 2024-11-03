import 'package:ecommerce/routes.dart';
import 'package:ecommerce/screens/categories_screen.dart';
import 'package:ecommerce/widgets/container_button_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ProductScreen extends StatefulWidget {
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int counter = 1;
  Map<String, String?> info = {};

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void decrementCounter() {
    if (counter > 1) {
      setState(() {
        counter--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    info = ModalRoute.of(context)!.settings.arguments as Map<String, String?>;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
          iconSize: 30,
        ),
      ),
      body: _buildProductDetails(),
    );
  }

  Widget _buildProductDetails() {
    final String imageUrl = info['image'].toString();
    final String productName = info['nameProd'].toString();
    final String price = info['price'].toString();
    final String description = info['description'].toString();
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Product Image
              Image.network(
                imageUrl,
                height: 350,
                width: MediaQuery.of(context).size.width,
                fit: BoxFit.fitHeight,
              ),

              // Divider between the image and the rest of the content
              const SizedBox(height: 20),
              const Divider(
                thickness: 5, // Thickness of the divider
                color: Colors.amber, // Color of the divider
              ),
              const SizedBox(height: 20),

              // Product Header: Name and Price
              _buildProductHeader(productName, price),

              const SizedBox(height: 10),

              // Product Description
              _buildProductDescription(description),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Quantidade",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),

              // Quantity Selector
              _buildQuantitySelector(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductHeader(String name, String price) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            name,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
        ),
        SizedBox(
          width: 5,
        ),
        Text(
          '${formatCurrencyBRL(double.parse(price.toString().replaceAll("R\$", "")))}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Color.fromARGB(241, 9, 197, 40),
          ),
        ),
      ],
    );
  }

  Widget _buildProductDescription(String description) {
    if (info.containsKey('description')) {
      return Align(
        alignment: Alignment.bottomLeft,
        child: Text(
          info['description'] ?? "",
          style: const TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      );
    } else {
      return Align(
        alignment: Alignment.bottomLeft,
        child: const Text(
          "",
          style: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
        ),
      );
    }
  }

  Widget _buildQuantitySelector() {
    return Row(children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 60,
                width: 150,
                decoration: BoxDecoration(
                  color: const Color(0x1F989797),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: decrementCounter,
                        icon: const Icon(Icons.exposure_minus_1),
                      ),
                      Text("$counter"),
                      IconButton(
                        onPressed: incrementCounter,
                        icon: const Icon(Icons.exposure_plus_1),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      SizedBox(
        width: 4,
      ),
      InkWell(
        onTap: () {
          _onAddToCart(info, 1);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Color.fromARGB(255, 242, 152, 34),
              content: Text(
                '${info['nameProd']} adicionado ao carrinho!',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          );
          Navigator.pop(context);
        },
        child: ContainerButtonModel(
          itext: 'Comprar',
          bgColor: Colors.green,
        ),
      ),
    ]);
  }

  String formatCurrencyBRL(double amount) {
    final format = NumberFormat.currency(
      locale: 'pt_BR',
      symbol: 'R\$',
      decimalDigits: 2,
    );
    return format.format(amount);
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
    });
  }
}
