import "package:ecommerce/screens/cart_screen.dart";
import "package:ecommerce/screens/home_screen.dart";
import "package:ecommerce/screens/login_screen.dart";
import "package:ecommerce/screens/navigationscreen.dart";
import "package:ecommerce/screens/onboarding_screen.dart";
import "package:ecommerce/screens/payment_method_screen.dart";
import "package:ecommerce/screens/product_screen.dart";
import "package:ecommerce/screens/splash_screen.dart";
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
      home: HomeScreen() ,
    );
  }
}