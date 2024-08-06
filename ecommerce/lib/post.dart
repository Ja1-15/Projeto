class Post{
  String? cdata;
  String? xlink_href;
  int? id;

  Post({this.cdata, this.xlink_href, this.id});

  Post.fromJson(Map<String, dynamic> json) {
    cdata = json['__cdata'];
    xlink_href= json['xlink:href'];
    id = json['id'];
  }
}