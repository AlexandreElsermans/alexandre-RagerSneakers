class Articles {
  static int nb = 0;

  int id;
  String title;
  double price;
  String description;
  List<String> img;

  Articles({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.img,
  });

  static Articles fromJson(Map<String, dynamic> json) {
    List<String> images = [];
    
    if (json['image'] != null) {
      if (json['image'] is List) {
        images = (json['image'] as List).map((e) => e.toString()).toList();
      } else if (json['image'] is String) {
        images = [json['image']];
      }
    }

    return Articles(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      img: images,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'image': img,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Articles &&
      other.id == id &&
      other.title == title &&
      other.price == price;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ price.hashCode;
}