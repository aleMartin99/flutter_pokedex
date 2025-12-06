/// Helper class to manage url
class ApiHelper {
  /// Base url
  static String baseUrl = 'https://pokeapi.co/api/v2/';

  /// Default limit for pagination
  static const int defaultLimit = 20;

  /// Builds the URL to request pokemons with pagination
  /// [offset] - The offset for pagination (default: 0)
  /// [limit] - The number of pokemons to fetch (default: 20)
  static String getPokemonsUrl({
    int offset = 0,
    int limit = defaultLimit,
  }) {
    return 'pokemon?offset=$offset&limit=$limit';
  }
}
