class FavoriteModel {
  final String id;
  final String title;
  final String image;
  final double price;

  const FavoriteModel({
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
      id: (map['id'] ?? '').toString(),
      title: (map['title'] ?? '').toString(),
      image: (map['image'] ?? '').toString(),
      price: (map['price'] is num)
          ? (map['price'] as num).toDouble()
          : double.tryParse(map['price'].toString()) ?? 0.0,
    );
  }

  FavoriteModel copyWith({
    String? id,
    String? title,
    String? image,
    double? price,
  }) {
    return FavoriteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      image: image ?? this.image,
      price: price ?? this.price,
    );
  }

  @override
  String toString() {
    return 'FavoriteModel(id: $id, title: $title, image: $image, price: $price)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is FavoriteModel &&
            other.id == id &&
            other.title == title &&
            other.image == image &&
            other.price == price;
  }

  @override
  int get hashCode =>
      id.hashCode ^ title.hashCode ^ image.hashCode ^ price.hashCode;
}