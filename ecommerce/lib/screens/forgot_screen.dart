
import 'package:ecommerce/screens/otp_screen.dart';
import 'package:ecommerce/screens/recovery_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForgotScreen extends StatefulWidget {
  const ForgotScreen({super.key});

  @override
  State<ForgotScreen> createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {

  bool clrButton = false;
  TextEditingController emailcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            SizedBox(height: 10,),
            Align(
              alignment: Alignment.topLeft,
              child: Text("Forgot Password",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold
              ),),
            ),
            SizedBox(height: 50),
            Text("Please enter your email address. You will receive a link to create a new password",
            style: TextStyle(
              fontSize: 15,
            ),),
            SizedBox(height: 10,),
            TextFormField(
              controller: emailcontroller,
              onChanged: (val){
                if(val != ""){
                  setState(() {
                    clrButton = true;
                  });
                }
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Email",
                suffix: InkWell(
                  onTap: (){
                    setState(() {
                      emailcontroller.clear();
                    });
                  },
                  child: Icon(CupertinoIcons.multiply,
                  color: Color(0xFFEf6969),),
                )
              ),
            ),
            SizedBox(height: 50,),
            ElevatedButton(
                        onPressed: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context) => RecoveryScreen()));
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
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(height: 20,),
                              Text("OR"),
                              TextButton(onPressed: (){
                                Navigator.push(context,
                                MaterialPageRoute(builder: (context) => OTPScreen()));
                              }, 
                              child: Text("Verify Using Number",
                              style: TextStyle(
                                color: Color(0xFFEF6969),
                                fontSize: 16,
                                fontWeight: FontWeight.w600
                              ),),
                              )
                            ],
                          )
          ],
        ),),
),
    );
  }
}