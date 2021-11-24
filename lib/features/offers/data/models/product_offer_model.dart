import 'package:nubank_marketplace/features/offers/data/models/product_model.dart';
import 'package:nubank_marketplace/features/offers/domain/entities/product.dart';
import 'package:nubank_marketplace/features/offers/domain/entities/product_offer.dart';

class ProductOfferModel extends ProductOffer {
  ProductOfferModel({String id, int price, ProductModel product})
      : super(id: id, price: price, product: product);

  factory ProductOfferModel.fromJson(Map<String, dynamic> json) =>
      ProductOfferModel(
          id: json['id'],
          price: json['price'] != null ? int.tryParse(json['price']) : 0,
          product: json['product'] != null
              ? ProductModel.fromJson(json['product'])
              : null);
}
