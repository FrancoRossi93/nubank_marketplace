import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:nubank_marketplace/features/user/data/datasources/user_local_data_source.dart';

import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  UserLocalDataSourceImpl localDataSourceImpl;
  MockSharedPreferences mockSharedPreferences;
  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localDataSourceImpl = UserLocalDataSourceImpl(mockSharedPreferences);
  });

  group('cache user token', () {
    final tUserToken = "token";

    test('should store the token on shared preferences', () {
      //act
      localDataSourceImpl.cacheUserToken();
      //assert
      verify(mockSharedPreferences.setString(CACHED_TOKEN, tUserToken));
    });
  });
}
