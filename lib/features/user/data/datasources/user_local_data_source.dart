import 'package:shared_preferences/shared_preferences.dart';

const CACHED_TOKEN = "TOKEN";

abstract class UserLocalDataSource {
  Future<void> cacheUserToken();
}

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserLocalDataSourceImpl(this.sharedPreferences);
  @override
  Future<void> cacheUserToken() {
    return sharedPreferences.setString(CACHED_TOKEN,
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJhd2Vzb21lY3VzdG9tZXJAZ21haWwuY29tIn0.cGT2KqtmT8KNIJhyww3T8fAzUsCD5_vxuHl5WbXtp8c");
  }
}
