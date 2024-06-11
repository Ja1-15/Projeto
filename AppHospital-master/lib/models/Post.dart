import 'dart:ffi';
export 'package:apphospital/main.dart';

//Mexe aqui não

class Post {
  final String nome;
  final Int tipo;
  final String rua;
  final Int numero;
  final String bairro;
  final String cidade;
  final String uf;
  final double latitude;
  final double longitude;

  Post({
    required this.nome,
    required this.tipo,
    required this.rua,
    required this.numero,
    required this.bairro,
    required this.cidade,
    required this.uf,
    required this.longitude,
    required this.latitude,
  });
}
