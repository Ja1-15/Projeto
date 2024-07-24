import 'package:ecommerce/screens/order_confirm_screen.dart';
import 'package:ecommerce/screens/order_success_screen.dart';
import 'package:ecommerce/screens/shipping_adress_screen.dart';
import 'package:ecommerce/widgets/container_button_model.dart';
import 'package:flutter/material.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  int _type = 1;  
  void _handleRadio(Object? e) => setState(() {
    _type = e as int;
  });

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; 
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment Method"),
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Column(
                children: [
        
                  //AMAZON
        
                  SizedBox(height: 40),
                  Container(
                    width: size.width,
                    height: 55,
                    decoration: BoxDecoration(
                      border: _type == 1 ? Border.all(width: 1, color: Color(0xFFEF6969)) 
                      : Border.all(width: 0.3, color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.transparent,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Radio(value: 1, groupValue: _type, onChanged:_handleRadio,
                                activeColor: Color(0xFFEF6969), 
                                ),
                                Text("Amazon Pay",
                                style: _type == 1 ? TextStyle(fontSize: 15,
                                fontWeight: FontWeight.w500, color: Colors.black
                                ) : TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey
                                ),
                                ),
                              ],
                            ),
                            Image.asset("images/amazon-pay.png",
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
        
                  //Cartão
        
                  Container(
                    width: size.width,
                    height: 55,
                    decoration: BoxDecoration(
                      border: _type == 2 ? Border.all(width: 1, color: Color(0xFFEF6969)) 
                      : Border.all(width: 0.3, color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.transparent,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Radio(value: 2, groupValue: _type, onChanged:_handleRadio,
                                activeColor: Color(0xFFEF6969), 
                                ),
                                Text("Cartão",
                                style: _type == 2 ? TextStyle(fontSize: 15,
                                fontWeight: FontWeight.w500, color: Colors.black
                                ) : TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey
                                ),
                                ),
                              ],                           
                            ),
                            Image.asset("images/visa.png",
                            width: 45,
                            fit: BoxFit.cover,),
                            Image.asset(
                              "images/master-card.png"
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
        
                  SizedBox(height: 15),
        
                  //PAYPAL
        
                  Container(
                    width: size.width,
                    height: 55,
                    decoration: BoxDecoration(
                      border: _type == 3 ? Border.all(width: 1, color: Color(0xFFEF6969)) 
                      : Border.all(width: 0.3, color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.transparent,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Radio(value: 3, groupValue: _type, onChanged:_handleRadio,
                                activeColor: Color(0xFFEF6969), 
                                ),
                                Text("PayPal",
                                style: _type == 3 ? TextStyle(fontSize: 15,
                                fontWeight: FontWeight.w500, color: Colors.black
                                ) : TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey
                                ),
                                ),
                              ],                           
                            ),
                            Image.asset(
                            "images/paypal.png",
                            width: 45,
                            fit: BoxFit.cover,
                          ),
                ],
              ),
            ),
          ),
         ),
                  SizedBox(height: 15),
        
                  //Google Pay
        
                  Container(
                    width: size.width,
                    height: 55,
                    decoration: BoxDecoration(
                      border: _type == 4 ? Border.all(width: 1, color: Color(0xFFEF6969)) 
                      : Border.all(width: 0.3, color: Colors.grey),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.transparent,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Radio(value: 4, groupValue: _type, onChanged:_handleRadio,
                                activeColor: Color(0xFFEF6969), 
                                ),
                                Text("Google Pay",
                                style: _type == 4 ? TextStyle(fontSize: 15,
                                fontWeight: FontWeight.w500, color: Colors.black
                                ) : TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey
                                ),
                                ),
                              ],                           
                            ),
                            Image.asset(
                            "images/icon2.png",
                            width: 45,
                            fit: BoxFit.cover,
                          ),
                ],
              ),
            ),
          ),
         ),
         SizedBox(height: 100,),
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Sub-Total",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey
            ),),
             Text("\$ 300.50",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),),
          ],
         ),
         SizedBox(height: 15,),
         Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Shipping Fee",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: Colors.grey
            ),),
             Text("\$ 15.00",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),),
          ],
         ),
         Divider(
         height: 30, 
         color: Colors.black,
         ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Total Payment",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black
                ),),
                Text("\$ 315.50",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.redAccent
                ),),
              ],
            ),
            SizedBox(height: 70,),
            InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder:(context) => OrderConfirmScreen()));
              },
              child: ContainerButtonModel(
                itext: "Confirm Payment",
                containerWidth: size.width,
                bgColor: Color(0xFFEF6969),
                ))
            ],
             ),
            ),
          ),
        ),
      ),
    );
  }
}