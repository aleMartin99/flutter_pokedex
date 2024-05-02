/// Helper class to manage url
class ApiHelper {
  /// Base url
  static String baseUrl = 'https://pokeapi.co/api/v2/';

  /// Url to request pokemons
  /// For mvp purposes only fetching 151 pokemons, this pokemons
  /// corresponds to Kanto region
  /// //TODO condition limit
  static String getPokemonsUrl = 'pokemon?limit=151';
}
