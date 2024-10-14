import 'package:ecommerce/screens/categories_screen.dart';
import 'package:ecommerce/screens/home_screen.dart';
import 'package:ecommerce/screens/search_screen.dart';
import 'package:flutter/material.dart';

class Navigationscreen extends StatefulWidget {
  const Navigationscreen({super.key});

  @override
  State<Navigationscreen> createState() => _NavigationscreenState();
}

class _NavigationscreenState extends State<Navigationscreen> {
  int pageIndex = 0;
  int cartItemCount = 0; // This will hold the count of items in the cart
  List<Widget> pages = [HomeScreen(), SearchScreen()];

  @override
  Widget build(BuildContext context) {
    var filtered =
        // ignore: unnecessary_null_comparison
        (cart_cat).where((item) => item != null && item.isNotEmpty).toList();
    cartItemCount = filtered.length;
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: pageIndex,
        onTap: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            label: 'Search',
          ),
        ],
      ),
    );
  }
}
