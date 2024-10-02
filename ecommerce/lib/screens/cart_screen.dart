import 'package:ecommerce/routes.dart';
import 'package:ecommerce/screens/categories_screen.dart';
import 'package:ecommerce/screens/payment_method_screen.dart';
import 'package:collection/collection.dart';
import 'package:ecommerce/screens/products_screen.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Data Lists for storing cart info
  List<Map<String, dynamic>> cartItems = [{}];
  List<int> itemQuantities = [];

  @override
  void initState() {
    super.initState();
    // Initializing cart items (assuming cart_prod and cart_cat are available)
    // Remove empty elements if any
    cartItems = (cart_cat.isNotEmpty ? cart_cat : cart_prod)
        .where((item) => item != null && item.isNotEmpty)
        .toList();
    print("Filtered Cart Items: $cartItems");
    itemQuantities = List<int>.filled(cartItems.length, 1);
  }

  // Increases the quantity of an item
  void incrementCounter(int index) {
    setState(() {
      itemQuantities[index]++;
    });
  }

  // Decreases the quantity of an item, ensuring it doesn't go below 1
  void decrementCounter(int index) {
    setState(() {
      if (itemQuantities[index] > 1) itemQuantities[index]--;
    });
  }

  // Formats the currency for BRL
  String formatCurrencyBRL(double value) {
    return 'R\$ ${value.toStringAsFixed(2)}';
  }

  // Calculates the total price of the cart
  double calculateTotal() {
    return cartItems.asMap().entries.map((entry) {
      int index = entry.key;
      if (entry.value['price'] == double) {
        double price = entry.value['price'];
        return price * itemQuantities[index];
      } else {
        double price = double.parse(entry.value['price']);
        return price * itemQuantities[index];
      }
    }).sum;
  }

  @override
  Widget build(BuildContext context) {
    if (cartItems.isNotEmpty == true) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Carrinho"),
          automaticallyImplyLeading: false,
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.black,
          elevation: 0,
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                ListView.builder(
                  itemCount: cartItems.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    var item = cartItems[index];
                    var quantity = itemQuantities[index];
                    var productName = item['nameProd'];
                    var productPrice = double.parse(item['price']);
                    var productImage = item['image'];
                    var productDescription = item['description'];

                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Checkbox for selecting items (optional)
                          const Checkbox(
                            value: true,
                            splashRadius: 20,
                            activeColor: Color(0xFFEF6969),
                            onChanged: null,
                          ),
                          // Product Image
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              productImage,
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 20),
                          // Product Information
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Product name and quantity
                                Text(
                                  "$quantity x $productName",
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                // Product description
                                Text(
                                  productDescription,
                                  overflow: TextOverflow.clip,
                                  maxLines: 2,
                                  style: const TextStyle(
                                      color: Colors.black26, fontSize: 16),
                                ),
                                const SizedBox(height: 10),
                                // Product price
                                Text(
                                  formatCurrencyBRL(productPrice * quantity),
                                  style: const TextStyle(
                                    color: Color(0xFFEF6969),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                // Quantity controls
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Container(
                                      height: 60,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: const Color(0x1F989797),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              decrementCounter(index);
                                            },
                                            icon: const Icon(Icons.remove),
                                          ),
                                          Text("$quantity"),
                                          IconButton(
                                            onPressed: () {
                                              incrementCounter(index);
                                            },
                                            icon: const Icon(Icons.add),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                const Divider(
                  height: 20,
                  thickness: 2,
                  color: Colors.black,
                ),
                // Total Payment Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Total Payment",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      formatCurrencyBRL(calculateTotal()),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFFEF6969),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Payment Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentMethodScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 65),
                    backgroundColor: const Color(0xFFEF6969),
                  ),
                  child: const Text(
                    "Pagamento",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Image.asset('images/carrinho_vazio.png'),
              Text(
                "Carrinho vazio",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      );
    }
  }
}
