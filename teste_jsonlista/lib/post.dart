import 'dart:ffi';

class Post{
  Int? id; 
  Int? telefone;
  String? email;
  String? nome;

  Post({this.id, this.telefone, this.email, this.nome})

  Post.fromJson
}