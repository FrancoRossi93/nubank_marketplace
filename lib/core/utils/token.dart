import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nubank_marketplace/core/exceptions.dart';
import 'package:nubank_marketplace/features/user/data/datasources/user_local_data_source.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenHelper {
  Future<String> getCachedToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.containsKey(CACHED_TOKEN)) {
      bool tokenIsExpired =
          JwtDecoder.isExpired(sharedPreferences.getString(CACHED_TOKEN)) ??
              false;
      if (tokenIsExpired) {
        //This block is functional and its here because no expiraton date has been added to token, so tokenIsExpired will be false (because isExpired() will always throw null/error). Otherwise this block should have an endpoint call with a refresh token to update access token.
        sharedPreferences.setString(CACHED_TOKEN,
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhd2Vzb21lY3VzdG9tZXJAZ21haWwuY29tIn0.cGT2KqtmT8KNIJhyww3T8fAzUsCD5_vxuHl5WbXtp8c");
        throw CacheExcepction(errorCode: 1);
      } else {
        return sharedPreferences.getString(CACHED_TOKEN);
      }
    } else {
      throw CacheExcepction(errorCode: 0);
    }
  }
}
