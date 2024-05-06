import 'package:flutter_pokedex/core/errors/failures.dart';
import 'package:flutter_pokedex/core/utils/utils_exports.dart';
import 'package:flutter_pokedex/domain/entities/pokemon.dart';
import 'package:flutter_pokedex/domain/usecases/remove_captured_pokemon/remove_captured_pokemon_params.dart';
import 'package:fpdart/fpdart.dart';

///RemoveCapturedPokemonUseCase
class RemoveCapturedPokemonUseCase
    extends UseCase<Unit, RemoveCapturedPokemonParams> {
  ///
  RemoveCapturedPokemonUseCase({required this.removeCapturedPokemon});

  ///
  final Future<Either<Failure, Unit>> Function(Pokemon capturedPokemon)
      removeCapturedPokemon;

  @override
  Future<Either<Failure, Unit>> call(RemoveCapturedPokemonParams params) =>
      removeCapturedPokemon(params.capturedPokemon);
}
