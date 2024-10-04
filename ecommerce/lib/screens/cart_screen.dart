import 'package:ecommerce/routes.dart';
import 'package:ecommerce/screens/categories_screen.dart';
import 'package:ecommerce/screens/payment_method_screen.dart';
import 'package:ecommerce/screens/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  String formatCurrencyBRL(double amount) {
    final format =
        NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$', decimalDigits: 2);
    return format.format(amount);
  }

  // Calculates the total price of the cart
  double calculateTotal() {
    return cartItems.asMap().entries.map((entry) {
      int index = entry.key;
      String rep =
          (entry.value['price']?.toString() ?? '0').replaceAll("R\$ ", '');
      double price = double.parse(rep);
      return price * itemQuantities[index];
    }).fold(0.0, (previousValue, element) => previousValue + element);
  }

  @override
  Widget build(BuildContext context) {
    var info = ModalRoute.of(context)!.settings.arguments
        as List<Map<String, dynamic>>;
    itemQuantities = List<int>.filled(cartItems.length, 1);
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
                    var item = info[index];
                    var quantity = itemQuantities[index];
                    // Adding null safety for cart item properties
                    var productName =
                        item['nameProd'] ?? 'Produto desconhecido';
                    var productPrice = item['price'];
                    var productImage = item['image'] ??
                        'https://via.placeholder.com/150'; // Default placeholder image
                    var productDescription =
                        item['description'] ?? 'Descrição indisponível';

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
                          // Product Image with null safety
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
                                // Product price with null safety
                                Text(
                                  formatCurrencyBRL((productPrice) * quantity),
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
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Text("Voltar")),
        ),
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
