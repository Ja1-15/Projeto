import 'package:ecommerce/screens/otpverify_screen.dart';
import 'package:flutter/material.dart';
class OTPScreen extends StatelessWidget {
  const OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
            SizedBox(height: 10,),
            Align(
              alignment: Alignment.topLeft,
              child: Text("Forgot Password \nUsing number",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),),
            ),
            SizedBox(height: 30),
            Text("Please enter your number. You will receive a code to create a new password",
            style: TextStyle(
              fontSize: 15,
            ),),
            SizedBox(height: 10,),        
            TextFormField(
              decoration: InputDecoration(
                labelText: "Enter Number",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30,),
            ElevatedButton(
                        onPressed: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context) => OtpverifyScreen()));
                          },
                          child: Text("Send Code", 
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18
                          ),),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size.fromHeight(55),
                            backgroundColor: Color(0xFFEF6969),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)
                            )
                          ),),
            ],
        ),),
      ),
    );
  }
}