import 'package:ecommerce/routes.dart';
import 'package:ecommerce/screens/payment_method_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CartScreen extends StatefulWidget {
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Data Lists for storing cart info
  List<Map<String, dynamic>> cartItems = [];

  @override
  void initState() {
    super.initState();

    // Get the cart items from the previous screen via arguments
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final info = ModalRoute.of(context)!.settings.arguments
          as List<Map<String, dynamic>>;
      setState(() {
        cartItems = info.where((item) => item.isNotEmpty).toList();
        for (var item in cartItems) {
          item['quantity'] ??= 1;
        }
      });
    });
  }

  void incrementCounter(int index) {
    setState(() {
      cartItems[index]['quantity']++;
    });
  }

  void decrementCounter(int index) {
    setState(() {
      if (cartItems[index]['quantity'] > 1) {
        cartItems[index]['quantity']--;
      }
    });
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  String formatCurrencyBRL(double amount) {
    final format =
        NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$', decimalDigits: 2);
    return format.format(amount);
  }

  double calculateTotal() {
    return cartItems.map((item) {
      String rep = (item['price']?.toString() ?? '0').replaceAll("R\$ ", '');
      double price = double.parse(rep);
      return price * (item['quantity'] ?? 1);
    }).fold(0.0, (previousValue, element) => previousValue + element);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Seu Carrinho"),
        automaticallyImplyLeading: false,
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context, cartItems);
          },
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Column(
              children: [
                SizedBox(
                  height: 100,
                ),
                Image.asset('images/carrinho_vazio.png'),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Seu carrinho está vazio",
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 22),
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context, cartItems);
                    },
                    child: Text(
                      'Voltar',
                      style:
                          TextStyle(color: Color.fromARGB(255, 241, 151, 55)),
                    ))
              ],
            )) // Show loader until items are populated
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    ListView.builder(
                      itemCount: cartItems
                          .length, // This will now reflect the actual number of items
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        var item = cartItems[index];
                        var quantity = item['quantity'];
                        var productName =
                            item['nameProd'] ?? 'Produto desconhecido';
                        var productPrice =
                            item['price'].toString().replaceAll("R\$", "");
                        var productImage =
                            item['image'] ?? 'https://via.placeholder.com/150';
                        var productDescription =
                            item['description'] ?? 'Descrição indisponível';

                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  productImage,
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
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
                                    Text(
                                      productDescription,
                                      overflow: TextOverflow.clip,
                                      maxLines: 2,
                                      style: const TextStyle(
                                          color: Colors.black26, fontSize: 16),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      formatCurrencyBRL(
                                          double.parse(productPrice) *
                                              quantity),
                                      style: const TextStyle(
                                        color: Color.fromARGB(255, 21, 202, 36),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          height: 60,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: const Color(0x1F989797),
                                            borderRadius:
                                                BorderRadius.circular(30),
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
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            removeItem(index);
                                          },
                                          icon: const Icon(Icons.delete,
                                              color: Colors.red),
                                        ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "   Total:",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          formatCurrencyBRL(calculateTotal()),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            color: Color.fromARGB(255, 21, 202, 36),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
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
                        backgroundColor: Color.fromARGB(255, 241, 151, 55),
                      ),
                      child: const Text(
                        "Pagamento",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
