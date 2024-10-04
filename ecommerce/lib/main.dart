import "package:ecommerce/routes.dart";
import "package:ecommerce/screens/cart_screen.dart";
import "package:ecommerce/screens/categories_screen.dart";
import "package:ecommerce/screens/login_screen.dart";
import "package:ecommerce/screens/navigationscreen.dart";
import "package:ecommerce/screens/products_screen.dart";
import "package:ecommerce/screens/signup_screen.dart";
import "package:flutter/material.dart";
import "package:flutter_native_splash/flutter_native_splash.dart";

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Future.delayed(const Duration(seconds: 3));
  FlutterNativeSplash.remove();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ecommerce Shop",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFFEF6969),
      ),
      home: Navigationscreen(),
      routes: {
        AppRoutes.PRODUCTS: (_) => ProductScreen(),
        AppRoutes.CATEGORIES: (_) => CategoryDropDown(),
        AppRoutes.CART: (_) => CartScreen(),
        AppRoutes.LOGIN: (_) => LoginScreen(),
        AppRoutes.SIGNUP: (_) => SignupScreen(),
      },
    );
  }
}
