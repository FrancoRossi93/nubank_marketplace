import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nubank_marketplace/core/exceptions.dart';

import 'package:nubank_marketplace/core/utils/token.dart';
import 'package:nubank_marketplace/features/api_data/data/models/api_data_model.dart';
import 'package:nubank_marketplace/features/api_data/domain/entities/api_data.dart';

abstract class ApiDataRemoteSource {
  /// Calls the GET api data endpoint
  ///
  /// Throws a [ServerException] for all error codes.
  Future<ApiData> getApiData();
}

class ApiDataRemoteSourceImpl implements ApiDataRemoteSource {
  final TokenHelper tokenHelper;
  final http.Client client;

  ApiDataRemoteSourceImpl({this.client, this.tokenHelper});

  @override
  Future<ApiData> getApiData() async {
    try {
      final token = await tokenHelper.getCachedToken();
      final query = json.encode(
          "query{viewer{idnamebalanceoffers {id,price,product {id,name,description,image}}}");
      final response = await client.get(
          Uri.parse(
              'https://staging-nu-needful-things.nubank.com.br/graphql?query=$query'),
          headers: {"Authorization": "Bearer $token"});
      if (response.statusCode == 200) {
        final result =
            ApiDataModel.fromJson(json.decode(response.body)["data"]["viewer"]);
        return result;
      } else {
        throw ServerException(message: 'Error en el servidor');
      }
    } catch (e) {
      throw ServerException(message: e);
    }
  }
}
