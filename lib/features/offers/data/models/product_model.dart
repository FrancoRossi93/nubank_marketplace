import 'package:equatable/equatable.dart';
import 'package:nubank_marketplace/features/offers/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({String id, String name, String description, String imageUrl})
      : super(id: id, name: name, description: description, imageUrl: imageUrl);
  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['image']);
}
