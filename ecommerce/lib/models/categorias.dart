class Categoria {
  int? id;
  String? name;
  List? subcategories;
  List? products;
  
  Categoria({this.id, this.name, this.products, this.subcategories});

  Categoria.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    products = json['associations']['products'];
    subcategories = json['associations']['categories'];
  }
}