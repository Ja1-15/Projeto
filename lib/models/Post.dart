import 'dart:ffi';
import 'dart:io';
import 'package:http/http.dart' as http;
export 'package:apphospital/main.dart';

class Post {
  final double latitude;
  final double longitude;
  final int radius;

  Post({
    required this.latitude,
    required this.longitude,
    required this.radius,
  });
}
