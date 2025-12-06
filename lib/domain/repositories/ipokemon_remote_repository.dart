// ignore_for_file: one_member_abstracts

import 'package:flutter_pokedex/core/errors/failures.dart';
import 'package:flutter_pokedex/domain/entities/pokemon.dart';
import 'package:fpdart/fpdart.dart';

/// Remote Pokemon repository interface
abstract class IPokemonRemoteRepository {
  /// Gets a list of pokemons with pagination
  /// [offset] - The offset for pagination (default: 0)
  /// [limit] - The number of pokemons to fetch (default: 20)
  Future<Either<Failure, List<Pokemon>>> getPokemons({
    int offset = 0,
    int limit = 20,
  });
}
