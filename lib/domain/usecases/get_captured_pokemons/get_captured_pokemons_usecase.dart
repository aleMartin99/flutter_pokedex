import 'package:flutter_pokedex/core/errors/failures.dart';
import 'package:flutter_pokedex/core/utils/utils_exports.dart';
import 'package:flutter_pokedex/domain/entities/pokemon.dart';
import 'package:fpdart/fpdart.dart';

/// GetCapturedPokemonsUsecase class
class GetCapturedPokemonsUsecase extends UseCase<List<Pokemon>, NoParams> {
  ///
  GetCapturedPokemonsUsecase({required this.getCapturedPokemons});

  /// Fetches the pokemons
  final Future<Either<Failure, List<Pokemon>>> Function() getCapturedPokemons;

  @override
  Future<Either<Failure, List<Pokemon>>> call(NoParams params) =>
      getCapturedPokemons();
}
