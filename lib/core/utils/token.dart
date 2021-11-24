import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:nubank_marketplace/core/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

const CACHED_USER = "CACHED_USER";
const CACHED_TOKEN = "TOKEN";
const CACHED_REFRESH_TOKEN = "REFRESH_TOKEN";

class TokenHelper {
  Future<String> getCachedToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    if (sharedPreferences.containsKey(CACHED_TOKEN)) {
      if (JwtDecoder.isExpired(sharedPreferences.getString(CACHED_TOKEN))) {
        throw CacheExcepction(errorCode: 1);
      } else {
        return sharedPreferences.getString(CACHED_TOKEN);
      }
    } else {
      throw CacheExcepction(errorCode: 0);
    }
  }
}
