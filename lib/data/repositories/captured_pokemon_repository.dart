import 'package:flutter_pokedex/core/errors/failures.dart';
import 'package:flutter_pokedex/core/services/services_exports.dart';
import 'package:flutter_pokedex/data/datasources/local_datasource/local_datasource_exports.dart';
import 'package:flutter_pokedex/data/models/local_models/local_models_exports.dart';
import 'package:flutter_pokedex/domain/entities/pokemon.dart';
import 'package:flutter_pokedex/domain/repositories/ipokemon_local_repository.dart';
import 'package:fpdart/fpdart.dart';

/// CapturedPokemonRepository implementation
class CapturedPokemonRepository implements IPokemonLocalRepository {
  ///
  CapturedPokemonRepository(this.datasource);

  /// ICapturedPokemonDatasource
  final ICapturedPokemonDatasource datasource;

  @override
  Future<Either<Failure, List<Pokemon>>> getCapturedPokemons() async {
    final getCapturedPokemonsResponse = await datasource.getCapturedPokemons();
    if (getCapturedPokemonsResponse.isRight()) {
      final pokemonsModelList =
          (getCapturedPokemonsResponse as Right).value as List<IsarPokemon>;

      // Convert from IsarPokemonModel to Pokemon-Entity
      final pokemonsList = pokemonsModelList
          .map(
            Pokemon.fromDBAdapter,
          )
          .toList();

      return right(pokemonsList);
    } else {
      return left((getCapturedPokemonsResponse as Left).value as Failure);
    }
  }

  /// insertCapturedPokemon method for ICapturedPokemonDatarsource
  @override
  Future<Either<Failure, Unit>> insertCapturedPokemon(
    Pokemon capturedPokemon,
  ) async {
    final insertCapturedPokemonsResponse = await datasource
        .insertCapturedPokemon(pokemonToDBAdapter(capturedPokemon));
    if (insertCapturedPokemonsResponse.isRight()) {
      return right(unit);
    } else {
      return left((insertCapturedPokemonsResponse as Left).value as Failure);
    }
  }

  @override
  Future<Either<Failure, Unit>> removeCapturedPokemon(
    Pokemon capturedPokemon,
  ) async {
    final removeCapturedPokemonsResponse = await datasource
        .removeCapturedPokemon(pokemonToDBAdapter(capturedPokemon));
    if (removeCapturedPokemonsResponse.isRight()) {
      return right(unit);
    } else {
      return left((removeCapturedPokemonsResponse as Left).value as Failure);
    }
  } // /// removeCapturedPokemon method for ICapturedPokemonDatarsource
}
