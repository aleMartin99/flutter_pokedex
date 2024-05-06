import 'package:flutter_pokedex/core/errors/failures.dart';
import 'package:flutter_pokedex/data/datasources/remote_datasource/remote_datasource_exports.dart';
import 'package:flutter_pokedex/data/models/remote_models/remote_models_exports.dart';
import 'package:flutter_pokedex/domain/entities/pokemon.dart';
import 'package:flutter_pokedex/domain/repositories/ipokemon_remote_repository.dart';
import 'package:fpdart/fpdart.dart';

/// PokemonRepository implementation
class PokemonRepository implements IPokemonRemoteRepository {
  ///
  PokemonRepository(this.datasource);

  /// PokemonDatasource
  final IPokemonDatasource datasource;

  @override
  Future<Either<Failure, List<Pokemon>>> getPokemons() async {
    final getPokemonsResponse = await datasource.getPokemons();
    if (getPokemonsResponse.isRight()) {
      final pokemonsModelList =
          (getPokemonsResponse as Right).value as List<PokemonModel>;

      // Convert from PokemonModel to PokemonEntity
      final pokemonsList = pokemonsModelList
          .map(
            Pokemon.fromModel,
          )
          .toList();

      return right(pokemonsList);
    } else {
      return left((getPokemonsResponse as Left).value as Failure);
    }
  }
}
