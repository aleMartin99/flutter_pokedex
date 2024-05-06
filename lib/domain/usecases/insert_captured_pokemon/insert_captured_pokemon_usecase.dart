import 'package:flutter_pokedex/core/errors/failures.dart';
import 'package:flutter_pokedex/core/utils/utils_exports.dart';
import 'package:flutter_pokedex/domain/entities/pokemon.dart';
import 'package:flutter_pokedex/domain/usecases/insert_captured_pokemon/insert_captured_pokemon_params.dart';
import 'package:fpdart/fpdart.dart';

///InsertCapturedPokemonUseCase
class InsertCapturedPokemonUseCase
    extends UseCase<Unit, InsertCapturedPokemonParams> {
  ///
  InsertCapturedPokemonUseCase({required this.insertCapturedPokemon});

  ///
  final Future<Either<Failure, Unit>> Function(Pokemon capturedPokemon)
      insertCapturedPokemon;

  @override
  Future<Either<Failure, Unit>> call(InsertCapturedPokemonParams params) =>
      insertCapturedPokemon(params.capturedPokemon);
}
