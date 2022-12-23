import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

import '../models/product.dart';


///
/// Ref: https://docs.flutter.dev/cookbook/networking/fetch-data
///
class Services {
  Services._internal();

  static final Services _instance = Services._internal();

  factory Services() => _instance;

  String endpoint = 'https://fakestoreapi.com/products';
  // static const String endpoint = 'https://fakestoreapi.com/products?limit=5';

  Future<List<Product>> fetchProduct() async {

    List<Product> products = [];

    String urlPath = "$endpoint?limit=${Random().nextInt(20)}";

    var response = await http.get(Uri.parse(urlPath));

    if (response.statusCode == 200) {

      var dataBody = jsonDecode(response.body);

      for(var data in dataBody) {
        products.add(Product.fromJson(data));
      }
      return products;
    } else {
      throw Exception('Failed to load product');
    }
  }
}
