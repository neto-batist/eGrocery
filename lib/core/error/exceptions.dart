/// Exceção para erros ao acessar o servidor (ex: falha na API)
class ServerException implements Exception {
  final String message;
  ServerException([this.message = 'Erro no servidor']);

  @override
  String toString() => 'ServerException: $message';
}

/// Exceção para erros ao acessar o cache local (ex: SharedPreferences, Hive)
class CacheException implements Exception {
  final String message;
  CacheException([this.message = 'Erro ao acessar o cache']);

  @override
  String toString() => 'CacheException: $message';
}
