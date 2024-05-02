// ignore_for_file: one_member_abstracts

import 'package:flutter_pokedex/core/errors/failures.dart';
import 'package:flutter_pokedex/data/models/pokemon_model/pokemon_model.dart';
import 'package:fpdart/fpdart.dart';

/// Pokemon Datasource interface
abstract class IPokemonDatasource {
  /// getPokemons method for IPokemonDatarsource
  Future<Either<Failure, List<PokemonModel>>> getPokemons(
    List<dynamic> pokemonSubset,
  );
}
