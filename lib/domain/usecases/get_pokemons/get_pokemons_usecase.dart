import 'package:flutter_pokedex/core/errors/failures.dart';
import 'package:flutter_pokedex/core/utils/utils_exports.dart';
import 'package:flutter_pokedex/domain/entities/pokemon.dart';
import 'package:fpdart/fpdart.dart';

/// GetPokemonsUsecase class
class GetPokemonsUsecase extends UseCase<List<Pokemon>, NoParams> {
  ///
  GetPokemonsUsecase({required this.getPokemons});

  /// Fetches the pokemons
  final Future<Either<Failure, List<Pokemon>>> Function() getPokemons;

  @override
  Future<Either<Failure, List<Pokemon>>> call(NoParams params) => getPokemons();
}
