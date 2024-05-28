import 'dart:convert';
import 'dart:io';
import 'package:apphospital/models/Post.dart';
import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:apphospital/map_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

//Mexe nisso não!!!
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mapa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MapScreen(),
    );
  }
}
