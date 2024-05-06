// ignore_for_file: one_member_abstracts

import 'package:flutter_pokedex/core/errors/failures.dart';
import 'package:flutter_pokedex/domain/entities/pokemon.dart';
import 'package:fpdart/fpdart.dart';

/// Local Pokemon repository interface
abstract class IPokemonLocalRepository {
  /// getCapturedPokemons method for ICapturedPokemonDatarsource
  Future<Either<Failure, List<Pokemon>>> getCapturedPokemons();

  /// insertCapturedPokemon method for ICapturedPokemonDatarsource
  Future<Either<Failure, Unit>> insertCapturedPokemon(Pokemon capturedPokemon);

  /// removeCapturedPokemon method for ICapturedPokemonDatarsource
  Future<Either<Failure, Unit>> removeCapturedPokemon(Pokemon capturedPokemon);
}
