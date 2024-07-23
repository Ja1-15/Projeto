import 'package:ecommerce/screens/payment_method_screen.dart';
import 'package:ecommerce/widgets/container_button_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {

  List image = [
    "images/image1.jpg",
    "images/image2.jpg",
    "images/image3.jpg",
    "images/image4.jpg"
  ];

  List productTitle = [
    "Warm Zipper",
    "Knitted Wool",
    "Zipper Win",
    "Child Win"
  ];

  List prices = [
    "\$300",
    "\$350",
    "\$600",
    "\$60",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Carrinho"),
        leading: BackButton(),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                child: ListView.builder(
                  itemCount: image.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Checkbox(
                            value: true,
                            splashRadius: 20,
                            activeColor: Color(0xFFEF6969),
                            onChanged: (val) {}
                            ),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(image[index],
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(productTitle[index],
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text("Hooded Jacket",
                            style: TextStyle(
                              color: Colors.black26, fontSize: 16
                            ),),
                            SizedBox(height: 10,),
                            Text(prices[index],
                            style: TextStyle(
                              color: Color(0xFFEF6969),
                              fontSize: 18,
                              fontWeight: FontWeight.w900
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(CupertinoIcons.minus, 
                              color: Colors.greenAccent,),
                              SizedBox(width: 20,),
                              Text("1", 
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700
                              ),),
                              SizedBox(width: 5,),
                              Icon(CupertinoIcons.plus,
                              color: Color(0xFFEF6969),
                              
                              ),

                            ],
                          )
                        ],
                      ),
                    );
                  }
                  ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Select All",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16
                  ),),
                  Checkbox(
                    value: false,
                    splashRadius: 20,
                    activeColor: Color(0xFFEF6969),
                    onChanged: (val){
                      
                  }),
                ],
              ),
              Divider(height: 20, thickness: 2, color: Colors.black,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total Payment",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),),
                  Text("\$300.50",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                    color: Color(0xFFEF6969),
                  ),),
                ],
              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: (){},
                child: ElevatedButton(
                  onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentMethodScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(200, 65),
                      maximumSize: Size(200, 65),
                      backgroundColor: Color(0xFFEF6969),
                     ),
                    child: Text("Pagamento",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18
                    ),),),
              ),
            ],
          ),
          ),
      ),
      );
  }
}