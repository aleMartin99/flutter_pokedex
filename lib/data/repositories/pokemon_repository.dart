import 'package:flutter_pokedex/core/errors/failures.dart';
import 'package:flutter_pokedex/data/datasources/remote_datasource/datasource_exports.dart';
import 'package:flutter_pokedex/data/models/pokemon_model/pokemon_model.dart';
import 'package:flutter_pokedex/domain/entities/pokemon.dart';
import 'package:flutter_pokedex/domain/repositories/ipokemon_repository.dart';
import 'package:fpdart/fpdart.dart';

/// PokemonRepository implementation
class PokemonRepository implements IPokemonRepository {
  ///
  PokemonRepository(this.datasource);

  /// PokemonDatasource
  final IPokemonDatasource datasource;

  final sublist = [];

  @override
  Future<Either<Failure, List<Pokemon>>> getPokemons() async {
    //todo check sublist
    final getPokemonsResponse = await datasource.getPokemons(sublist);
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
