import 'package:ecommerce/screens/forgot_screen.dart';
import 'package:ecommerce/screens/home_screen.dart';
import 'package:ecommerce/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: SafeArea(
          child:Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 110,),
                Image.asset("images/freed.png"),
                SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Enter Email",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email),

                        ),
                      ),
                      SizedBox(height: 10,),
                      TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Enter Password",
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: Icon(Icons.remove_red_eye)
                        ),
                      ),
                      SizedBox(height: 30,),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                                onPressed: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ForgotScreen()));
                                }, 
                              child: Text("Forgot Password?",
                              style: TextStyle(
                                color: Color(0xFFEf6969),
                                fontSize: 16,
                                fontWeight: FontWeight.w600
                              ),)),
                      ),
                      ElevatedButton(
                        onPressed: (){
                          Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen()));
                          },
                          child: Text("Log In", 
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
                          SizedBox(height: 10,),
                          Text("OR"),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Dont have an account?",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 15
                              ),),
                              TextButton(
                                onPressed: (){
                                  Navigator.push(context,MaterialPageRoute(builder: (context) => SignupScreen()));
                                }, 
                              child: Text("Sign Up",
                              style: TextStyle(
                                color: Color(0xFFEf6969),
                                fontSize: 16,
                                fontWeight: FontWeight.w600
                              ),))
                            ],
                          )
                    ],
                  ),
                )
              ],
            ),
          )),
      ),
    );
  }
}