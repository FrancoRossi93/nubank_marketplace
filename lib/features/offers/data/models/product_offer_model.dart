import 'package:nubank_marketplace/features/offers/data/models/product_model.dart';

import 'package:nubank_marketplace/features/offers/domain/entities/product_offer.dart';

class ProductOfferModel extends ProductOffer {
  ProductOfferModel(
      {String id, int price, DateTime expirationDate, ProductModel product})
      : super(
            id: id,
            price: price,
            expirationDate: expirationDate,
            product: product);

  factory ProductOfferModel.fromJson(Map<String, dynamic> json) =>
      ProductOfferModel(
          id: json['id'],
          price: json['price'] != null ? (json['price'] as num).toInt() : 0,
          expirationDate:
              (json['id'] as String).contains('offer/microverse-battery')
                  ? DateTime.now().subtract(const Duration(days: 3))
                  : DateTime.now().add(const Duration(days: 1)),
          product: json['product'] != null
              ? ProductModel.fromJson(json['product'])
              : null);
}
