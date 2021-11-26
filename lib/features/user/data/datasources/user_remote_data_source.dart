import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nubank_marketplace/core/exceptions.dart';
import 'package:nubank_marketplace/core/utils/constants.dart';

import 'package:nubank_marketplace/core/utils/token.dart';
import 'package:nubank_marketplace/features/user/data/models/user_model.dart';
import 'package:nubank_marketplace/features/user/domain/entities/user.dart';

abstract class UserRemoteDataSource {
  /// Calls the POST api data endpoint
  /// Using graphql as a rest api
  /// Throws a [ServerException] for all error codes.
  Future<User> getUser();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final TokenHelper tokenHelper;
  final http.Client client;
  UserRemoteDataSourceImpl(this.client, this.tokenHelper);
  @override
  Future<User> getUser() async {
    try {
      final token = await tokenHelper.getCachedToken();
      final query = json.encode({
        "query": "{viewer{id name balance}}",
        "operationName": null,
        "variables": null
      });

      final response = await client.post(Uri.parse(API_URL),
          body: query,
          headers: {
            "Authorization": "Bearer $token",
            "Content-Type": "application/json"
          });
      if (response.statusCode == 200) {
        final user =
            UserModel.fromJson(json.decode(response.body)['data']['viewer']);
        return user;
      }
    } catch (e) {
      throw ServerException(message: 'Error en el servidor');
    }
  }
}
