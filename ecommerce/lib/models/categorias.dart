class Categorias {
  int? id;
  String? name;
  List? subcategories;
  List? products;
  
  Categorias({this.id, this.name, this.products, this.subcategories});

  Categorias.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    products = json['associations']['products'];
    subcategories = json['associations']['categories'];
  }
}