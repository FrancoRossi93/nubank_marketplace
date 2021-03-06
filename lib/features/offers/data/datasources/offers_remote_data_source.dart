import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nubank_marketplace/core/exceptions.dart';
import 'package:nubank_marketplace/core/utils/constants.dart';

import 'package:nubank_marketplace/core/utils/token.dart';
import 'package:nubank_marketplace/features/offers/data/models/product_offer_model.dart';
import 'package:nubank_marketplace/features/offers/domain/entities/product_offer.dart';

abstract class OffersRemoteDataSource {
  /// Calls the POST api data endpoint
  /// Using graphql as a rest api
  /// Throws a [ServerException] for all error codes.
  Future<List<ProductOffer>> getOffers();
}

class OffersRemoteDataSourceImpl implements OffersRemoteDataSource {
  final TokenHelper tokenHelper;
  final http.Client client;
  OffersRemoteDataSourceImpl(this.client, this.tokenHelper);
  @override
  Future<List<ProductOffer>> getOffers() async {
    try {
      final token = await tokenHelper.getCachedToken();
      final query = json.encode({
        "query":
            "{viewer{ offers {id,price,product {id name description image}}}}",
        "operationName": null,
        "variables": null
      });
      final response =
          await client.post(Uri.parse(API_URL), body: query, headers: {
        "Authorization":
            "Bearer $token",
        "Content-Type": "application/json"
      });
      if (response.statusCode == 200) {
        final offers =
            (json.decode(response.body)['data']['viewer']['offers'] as List)
                .map((e) => ProductOfferModel.fromJson(e))
                .toList();
        return offers;
      } else {
        throw ServerException(message: 'Something went wrong');
      }
    } catch (e) {
      throw ServerException(message: 'Server Error');
    }
  }
}
