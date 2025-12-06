// ignore_for_file: one_member_abstracts

import 'package:flutter_pokedex/core/errors/failures.dart';
import 'package:flutter_pokedex/data/models/remote_models/remote_models_exports.dart';
import 'package:fpdart/fpdart.dart';

/// Pokemon Datasource interface
abstract class IPokemonDatasource {
  /// getPokemons method for IPokemonDatarsource
  /// [offset] - The offset for pagination (default: 0)
  /// [limit] - The number of pokemons to fetch (default: 20)
  Future<Either<Failure, List<PokemonModel>>> getPokemons({
    int offset = 0,
    int limit = 20,
  });

  /// getEvolutionChain method for IPokemonDatasource
  /// [pokemonId] - The Pokemon ID to get evolution chain for
  Future<Either<Failure, EvolutionChainModel>> getEvolutionChain(
    int pokemonId,
  );
}
