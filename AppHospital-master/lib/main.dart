import 'package:flutter/material.dart';
import 'package:apphospital/map_screen.dart';

void main() {
  runApp(const MyApp());
}

//Tela principal ta no arquivo map_screen

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mapa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MapScreen(),
    );
  }
}
