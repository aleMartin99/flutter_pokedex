// ignore_for_file: one_member_abstracts
import 'package:flutter_pokedex/core/errors/failures.dart';
import 'package:flutter_pokedex/data/models/local_models/local_models_exports.dart';
import 'package:fpdart/fpdart.dart';

///Captured Pokemon Datasource interface
abstract class ICapturedPokemonDatasource {
  /// getCapturedPokemons method for ICapturedPokemonDatarsource
  Future<Either<Failure, List<IsarPokemon>>> getCapturedPokemons();

  /// insertCapturedPokemon method for ICapturedPokemonDatarsource
  Future<Either<Failure, Unit>> insertCapturedPokemon(
    IsarPokemon capturedPokemon,
  );

  /// removeCapturedPokemon method for ICapturedPokemonDatarsource
  Future<Either<Failure, Unit>> removeCapturedPokemon(
    IsarPokemon capturedPokemon,
  );
}
