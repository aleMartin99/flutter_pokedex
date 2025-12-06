import 'package:flutter_pokedex/core/errors/failures.dart';
import 'package:flutter_pokedex/core/utils/utils_exports.dart';
import 'package:flutter_pokedex/domain/entities/pokemon.dart';
import 'package:flutter_pokedex/domain/usecases/get_pokemons/get_pokemons_params.dart';
import 'package:fpdart/fpdart.dart';

/// GetPokemonsUsecase class
class GetPokemonsUsecase extends UseCase<List<Pokemon>, GetPokemonsParams> {
  ///
  GetPokemonsUsecase({required this.getPokemons});

  /// Fetches the pokemons with pagination
  final Future<Either<Failure, List<Pokemon>>> Function({
    int offset,
    int limit,
  }) getPokemons;

  @override
  Future<Either<Failure, List<Pokemon>>> call(GetPokemonsParams params) =>
      getPokemons(
        offset: params.offset,
        limit: params.limit,
      );
}
