import 'package:ecommerce/screens/order_confirm_screen.dart';
import 'package:flutter/material.dart';

class ShippingAdress extends StatelessWidget {
  const ShippingAdress({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add shipping address"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 10,),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Full Name"
                  ),
                ),
                SizedBox(height: 25,),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Mobile Number"
                  ),
                ),
                SizedBox(height: 25,),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Address"
                  ),
                ),
                SizedBox(height: 25,),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "City"
                  ),
                ),
                SizedBox(height: 25,),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "State/Province/Region"
                  ),
                ),
                SizedBox(height: 25,),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Zip(Postal Code)"
                  ),
                ),
                SizedBox(height: 30,),
                InkWell(
                onTap: (){},
                child: ElevatedButton(
                  onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => OrderConfirmScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(200, 65),
                      maximumSize: Size(200, 65),
                      backgroundColor: Color(0xFFEF6969),
                     ),
                    child: Text("Confirm Address",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18
                    ),),),
              ),
              ],
            ),
            ), 
          ),
        ),
    );
  }
}