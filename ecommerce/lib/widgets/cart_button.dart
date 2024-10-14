import 'package:ecommerce/routes.dart';
import 'package:ecommerce/screens/categories_screen.dart';
import 'package:flutter/material.dart';

class CartButton extends StatefulWidget {
  const CartButton({super.key});

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
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
    );
  }
}
