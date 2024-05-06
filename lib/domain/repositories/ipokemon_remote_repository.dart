// ignore_for_file: one_member_abstracts

import 'package:flutter_pokedex/core/errors/failures.dart';
import 'package:flutter_pokedex/domain/entities/pokemon.dart';
import 'package:fpdart/fpdart.dart';

/// Remote Pokemon repository interface
abstract class IPokemonRemoteRepository {
  ///
  Future<Either<Failure, List<Pokemon>>> getPokemons();
}
