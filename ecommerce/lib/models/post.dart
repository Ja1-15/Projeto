class Categoria {
  int? id;
  String? title;
  String? url;
  List? produtos;

  Categoria({this.id, this.title, this.url, this.produtos});

  Categoria.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['name'];
    url = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRvS7ds60JFMAcPLp8fH1BIEyPRXUDvRYYTxw&s';
    produtos = json['associations']['products'];
  }
}