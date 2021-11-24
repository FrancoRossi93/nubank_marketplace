import 'package:nubank_marketplace/features/init_settings/domain/entities/api_data.dart';
import 'package:nubank_marketplace/features/offers/data/models/product_offer_model.dart';
import 'package:nubank_marketplace/features/offers/domain/entities/product_offer.dart';
import 'package:nubank_marketplace/features/user/data/models/user_model.dart';
import 'package:nubank_marketplace/features/user/domain/entities/user.dart';

class ApiDataModel extends ApiData {
  ApiDataModel({User user, List<ProductOffer> productsOffer})
      : super(user: user, productsOffer: productsOffer);

  factory ApiDataModel.fromJson(Map<String, dynamic> json) => ApiDataModel(
      user: UserModel.fromJson(json),
      productsOffer: json['offers'] != null
          ? (json['offers'] as List)
              .map((e) => ProductOfferModel.fromJson(e))
              .toList()
          : []);
}
