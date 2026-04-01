// ignore_for_file: non_constant_identifier_names

class Articles {
  static double nb = 0;

  int id;
  String title;
  double price;
  String description;
  List<String> img;
  String? user_id;

  Articles({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.img,
    this.user_id,
  });

  static Articles fromJson(Map<String, dynamic> json) {
    List<String> images = [];
    
    if (json['img'] != null) {
      if (json['img'] is List) {
        images = (json['img'] as List).map((e) => e.toString()).toList();
      } else if (json['img'] is String) {
        if ((json['img']).contains(',')) {
          images = ([json['img']] as String).split(',');
        } else {
          images = json['img'];
        }
      }
    }

    return Articles(
      id: json['article_id'] ?? 0,
      title: json['title'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      img: images,
      user_id: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'article_id': id,
      'title': title,
      'price': price,
      'description': description,
      'img': img.join(','),
      'user_id': user_id,
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