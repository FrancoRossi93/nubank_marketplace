import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:nubank_marketplace/core/exceptions.dart';
import 'package:nubank_marketplace/core/utils/constants.dart';

import 'package:nubank_marketplace/core/utils/token.dart';
import 'package:nubank_marketplace/features/user/data/models/user_model.dart';
import 'package:nubank_marketplace/features/user/domain/entities/user.dart';

abstract class UserRemoteDataSource {
  /// Calls the GET api data endpoint
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

      final response =
          await client.post(Uri.parse(API_URL), body: query, headers: {
        "Authorization":
            "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhd2Vzb21lY3VzdG9tZXJAZ21haWwuY29tIn0.cGT2KqtmT8KNIJhyww3T8fAzUsCD5_vxuHl5WbXtp8c",
        "Content-Type": "application/json"
      });
      if (response.statusCode == 200) {
        final user =
            UserModel.fromJson(json.decode(response.body)['data']['viewer']);
        return user;
      }
    } catch (e) {
      throw ServerException(message: e);
    }
  }
}
