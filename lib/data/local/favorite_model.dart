class FavoriteModel {
  final String id;
  final String title;
  final String image;
  final double price;

  FavoriteModel({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'price': price,
    };
  }

  factory FavoriteModel.fromMap(Map<String, dynamic> map) {
    return FavoriteModel(
      id: map['id'],
      title: map['title'],
      image: map['image'],
      price: map['price'],
    );
  }
}