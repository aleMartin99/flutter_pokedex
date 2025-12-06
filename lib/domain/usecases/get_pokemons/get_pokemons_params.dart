/// Parameters for GetPokemonsUsecase
class GetPokemonsParams {
  /// Creates GetPokemonsParams
  const GetPokemonsParams({
    this.offset = 0,
    this.limit = 20,
  });

  /// The offset for pagination
  final int offset;

  /// The number of pokemons to fetch
  final int limit;
}

