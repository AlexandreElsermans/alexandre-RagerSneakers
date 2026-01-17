class Articles {
  static int nb = 0;

  int id;
  String title;
  int price;
  String description;
  List<String> img;

  Articles({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.img,
  });

  static Articles fromJson(Map<String, dynamic> json){
    return Articles(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
      img: json['image'],
    );
  }
}