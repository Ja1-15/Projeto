import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: 40,),
            CircleAvatar(
              radius: 70,
              backgroundImage: AssetImage("images/person.png"),
            ),
            const SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 5),
                    color: Colors.deepOrange.withOpacity(.2),
                    spreadRadius: 5, 
                    blurRadius: 10,
                  )
                ]
              ),
              child: ListTile(
                title: const Text("Nome"),
                subtitle: const Text("Joao"),
                leading: Icon(CupertinoIcons.person),
                tileColor: Colors.white,
              ),
            ),
            SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 5),
                    color: Colors.deepOrange.withOpacity(.2),
                    spreadRadius: 5, 
                    blurRadius: 10,
                  )
                ]
              ),
              child: ListTile(
                title: const Text("Email"),
                subtitle: const Text("teste@teste.com"),
                leading: Icon(CupertinoIcons.person),
                tileColor: Colors.white,
              ),
            ),
            SizedBox(height: 20,),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 5),
                    color: Colors.deepOrange.withOpacity(.2),
                    spreadRadius: 5, 
                    blurRadius: 10,
                  )
                ]
              ),
              child: ListTile(
                title: const Text("Endereço"),
                subtitle: const Text("Rua teste, quadra teste"),
                leading: Icon(CupertinoIcons.person),
                tileColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}