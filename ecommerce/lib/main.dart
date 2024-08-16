import "package:ecommerce/routes.dart";
import "package:ecommerce/screens/categories_screen.dart";
import "package:ecommerce/screens/navigationscreen.dart";
import "package:ecommerce/screens/product_view_screen.dart";
import "package:flutter/material.dart";

void main(List<String> args) {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: "Ecommerce Shop",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFFEF6969),
      ),
      home: Navigationscreen(),
      routes:  {AppRoutes.CATEGORIES: (_) => const CategoriesScreen(),
      AppRoutes.PRODUCTS : (_) => ProductScreen(),
      },
    );
  }
}