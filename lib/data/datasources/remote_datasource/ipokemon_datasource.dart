// ignore_for_file: one_member_abstracts

import 'package:flutter_pokedex/core/errors/failures.dart';
import 'package:flutter_pokedex/data/models/remote_models/remote_models_exports.dart';
import 'package:fpdart/fpdart.dart';

/// Pokemon Datasource interface
abstract class IPokemonDatasource {
  /// getPokemons method for IPokemonDatarsource
  Future<Either<Failure, List<PokemonModel>>> getPokemons();
}
