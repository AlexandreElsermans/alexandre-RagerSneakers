class Articles {
  static int nb = 0;

  int id;
  String title;
  int price;
  String description;

  Articles({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
  });

  static Articles fromJson(Map<String, dynamic> json){
    return Articles(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      description: json['description'],
    );
  }
}