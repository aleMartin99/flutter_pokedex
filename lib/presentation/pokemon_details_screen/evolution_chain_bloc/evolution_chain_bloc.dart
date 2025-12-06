// ignore_for_file: collection_methods_unrelated_type, inference_failure_on_untyped_parameter, lines_longer_than_80_chars, unnecessary_statements

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/core/errors/failures.dart';
import 'package:flutter_pokedex/core/utils/utils_exports.dart';
import 'package:flutter_pokedex/data/models/remote_models/remote_models_exports.dart';
import 'package:flutter_pokedex/domain/usecases/get_evolution_chain/get_evolution_chain_params.dart';
import 'package:flutter_pokedex/domain/usecases/get_evolution_chain/get_evolution_chain_usecase.dart';
import 'package:fpdart/fpdart.dart';

part 'evolution_chain_event.dart';
part 'evolution_chain_state.dart';
part 'evolution_chain_status.dart';

/// EvolutionChainBloc class
class EvolutionChainBloc extends Bloc<EvolutionChainEvent, EvolutionChainState>
    with BaseBloc {
  ///
  EvolutionChainBloc({
    required this.getEvolutionChainUsecase,
  }) : super(const EvolutionChainState()) {
    on<OnLoadEvolutionChainEvent>((event, emit) async {
      emit(
        state.copyWith(
          status: EvolutionChainStatus.loading,
        ),
      );

      /// call the usecase instance with pokemon id
      final responseGetEvolutionChain = await getEvolutionChainUsecase(
        GetEvolutionChainParams(
          pokemonId: event.pokemonId,
        ),
      );

      if (responseGetEvolutionChain.isRight()) {
        final evolutionChain =
            (responseGetEvolutionChain as Right).value as EvolutionChainModel?;

        secureEmit(
          state.copyWith(
            status: EvolutionChainStatus.success,
            evolutionChain: evolutionChain,
          ),
        );
      } else {
        final failure =
            (responseGetEvolutionChain as Left).value as Failure;
        secureEmit(
          state.copyWith(
            failure: failure.message,
            status: EvolutionChainStatus.failure,
          ),
        );
      }
    });
  }

  ///
  final GetEvolutionChainUsecase getEvolutionChainUsecase;
}

