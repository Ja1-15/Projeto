class Post {
  String? telefone;
  int? id;
  String? nome;
  String? email;

  Post({this.telefone, this.id, this.nome, this.email});

  Post.fromJson(Map<String, dynamic> json) {
    telefone = json['telefone'];
    id = json['id'];
    nome = json['nome'];
    email = json['email'];
  }
  Post.empty();

 
}