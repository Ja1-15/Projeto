import "package:ecommerce/routes.dart";
import "package:ecommerce/screens/cart_screen.dart";
import "package:ecommerce/screens/home_screen.dart";
import "package:ecommerce/screens/login_screen.dart";
import "package:ecommerce/screens/navigationscreen.dart";
import "package:ecommerce/screens/onboarding_screen.dart";
import "package:ecommerce/screens/order_confirm_screen.dart";
import "package:ecommerce/screens/payment_method_screen.dart";
import "package:ecommerce/screens/product_view_screen.dart";
import "package:ecommerce/screens/shipping_adress_screen.dart";
import "package:ecommerce/screens/splash_screen.dart";
import "package:ecommerce/screens/sub_categories_screen.dart";
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
      routes:  {AppRoutes.SUB_CATEGORIES: (_) => const SubCategoriesScreen(),
      AppRoutes.PRODUCTS : (_) => ProductScreen(),
      },
    );
  }
}