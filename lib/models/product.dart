class Product {
  final int id;
  final String title;
  final num price;
  final String description;
  final String image;
  final Map<String, dynamic> rating;

  const Product(
      {required this.id,
      required this.title,
      required this.price,
      required this.description,
      required this.image,
      required this.rating});

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
        id: map['id'],
        title: map['title'],
        price: map['price'],
        description: map['description'],
        image: map['image'],
        rating: map['rating']);
  }
}
