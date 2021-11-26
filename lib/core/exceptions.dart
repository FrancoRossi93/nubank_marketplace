class ServerException implements Exception {
  final String message;
  ServerException({this.message});
}

class CacheExcepction implements Exception {
  final int errorCode;
  CacheExcepction({this.errorCode});
}
