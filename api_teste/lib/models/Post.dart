import 'dart:ffi';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:api_teste/main.dart';

class Post {

  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String image;

  Post({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
  });
}