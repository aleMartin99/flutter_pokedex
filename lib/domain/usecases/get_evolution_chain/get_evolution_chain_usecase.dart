import 'package:flutter_pokedex/core/errors/failures.dart';
import 'package:flutter_pokedex/core/utils/utils_exports.dart';
import 'package:flutter_pokedex/data/models/remote_models/remote_models_exports.dart';
import 'package:flutter_pokedex/domain/usecases/get_evolution_chain/get_evolution_chain_params.dart';
import 'package:fpdart/fpdart.dart';

/// GetEvolutionChainUsecase class
class GetEvolutionChainUsecase
    extends UseCase<EvolutionChainModel, GetEvolutionChainParams> {
  ///
  GetEvolutionChainUsecase({required this.getEvolutionChain});

  /// Fetches the evolution chain for a Pokemon
  final Future<Either<Failure, EvolutionChainModel>> Function(int pokemonId)
      getEvolutionChain;

  @override
  Future<Either<Failure, EvolutionChainModel>> call(
    GetEvolutionChainParams params,
  ) =>
      getEvolutionChain(params.pokemonId);
}

