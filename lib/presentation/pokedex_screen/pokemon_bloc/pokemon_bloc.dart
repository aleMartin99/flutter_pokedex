// ignore_for_file: collection_methods_unrelated_type, inference_failure_on_untyped_parameter, lines_longer_than_80_chars

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/core/errors/failures.dart';
import 'package:flutter_pokedex/core/utils/utils_exports.dart';
import 'package:flutter_pokedex/domain/entities/pokemon.dart';
import 'package:flutter_pokedex/domain/usecases/get_pokemons/get_pokemons_usecase.dart';
import 'package:fpdart/fpdart.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';
part 'radio_station_status.dart';

/// PokemonBloc class
class PokemonBloc extends Bloc<PokemonEvent, PokemonState> with BaseBloc {
  ///
  PokemonBloc({required this.getPokemonsUsecase})
      : super(const PokemonState()) {
    on<OnLoadPokemonsEvent>((event, emit) async {
      emit(state.copyWith(status: PokemonStatus.loading));

      /// call the usecase instance
      final responseGetPokemons = await getPokemonsUsecase(NoParams());
      if (responseGetPokemons.isRight()) {
        final pokemonsList =
            (responseGetPokemons as Right).value as List<Pokemon>? ?? [];

        secureEmit(
          state.copyWith(
            status: PokemonStatus.success,
            pokemonsList: pokemonsList,
          ),
        );
      } else {
        final failure = (responseGetPokemons as Left).value as Failure;
        secureEmit(
          state.copyWith(
            failure: failure.message,
            status: PokemonStatus.failure,
          ),
        );
      }
    });
  }

  ///
  final GetPokemonsUsecase getPokemonsUsecase;
}
