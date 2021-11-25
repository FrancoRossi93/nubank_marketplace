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
      /* final token = await tokenHelper.getCachedToken(); */
      final query = json.encode({
        "query":
            "{viewer{id name balance offers {id,price,product {id,name,description,image}}}}",
        "operationName": null,
        "variables": null
      });

      final response = await client.post(
          Uri.parse('https://staging-nu-needful-things.nubank.com.br/query'),
          body: query,
          headers: {
            "Authorization":
                "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhd2Vzb21lY3VzdG9tZXJAZ21haWwuY29tIn0.cGT2KqtmT8KNIJhyww3T8fAzUsCD5_vxuHl5WbXtp8c",
            "Content-Type": "application/json"
          });
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
