import 'package:ecommerce/screens/navigationscreen.dart';
import 'package:flutter/material.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Image.asset("images/confirm.png"),
              SizedBox(height: 20,),
              Text("Success",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),),
              Text("Your order will delivered soon",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400
              ),),
              Text("Thanks for choosing our app",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400
              ),),
            ],
          ),
          SizedBox(height: 20,),
          InkWell(
                onTap: (){},
                child: ElevatedButton(
                  onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Navigationscreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(250, 70),
                      maximumSize: Size(250, 70),
                      backgroundColor: Color(0xFFEF6969),
                     ),
                    child: Text("Continue Shopping",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18
                    ),),),
              ),
         
        ],
      ),
    );
  }
}