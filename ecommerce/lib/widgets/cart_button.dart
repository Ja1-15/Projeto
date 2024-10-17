import 'package:ecommerce/routes.dart';
import 'package:ecommerce/screens/cart_screen.dart';
import 'package:ecommerce/screens/categories_screen.dart';
import 'package:ecommerce/screens/home_screen.dart';
import 'package:flutter/material.dart';

class CartButton extends StatefulWidget {
  const CartButton({super.key});

  @override
  State<CartButton> createState() => _CartButtonState();
}

class _CartButtonState extends State<CartButton> {
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
    return FloatingActionButton(
      onPressed: () {
        _navigateToCartScreen();
      },
      backgroundColor: Colors.white,
      child: Icon(Icons.shopping_cart),
    );
  }
}
