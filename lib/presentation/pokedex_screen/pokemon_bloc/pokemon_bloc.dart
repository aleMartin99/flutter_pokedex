// ignore_for_file: collection_methods_unrelated_type, inference_failure_on_untyped_parameter, lines_longer_than_80_chars, unnecessary_statements

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/core/errors/failures.dart';
import 'package:flutter_pokedex/core/utils/utils_exports.dart';
import 'package:flutter_pokedex/domain/entities/pokemon.dart';
import 'package:flutter_pokedex/domain/usecases/get_captured_pokemons/get_captured_pokemons_usecase.dart';
import 'package:flutter_pokedex/domain/usecases/get_pokemons/get_pokemons_usecase.dart';
import 'package:flutter_pokedex/domain/usecases/insert_captured_pokemon/insert_captured_pokemon_params.dart';
import 'package:flutter_pokedex/domain/usecases/insert_captured_pokemon/insert_captured_pokemon_usecase.dart';
import 'package:flutter_pokedex/domain/usecases/remove_captured_pokemon/remove_captured_pokemon_params.dart';
import 'package:flutter_pokedex/domain/usecases/remove_captured_pokemon/remove_captured_pokemon_usecase.dart';
import 'package:fpdart/fpdart.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';
part 'pokemon_status.dart';

/// PokemonBloc class
class PokemonBloc extends Bloc<PokemonEvent, PokemonState> with BaseBloc {
  ///
  PokemonBloc({
    required this.getPokemonsUsecase,
    required this.getCapturedPokemonsUsecase,
    required this.insertCapturedPokemonUseCase,
    required this.removeCapturedPokemonUseCase,
  }) : super(const PokemonState()) {
    on<OnLoadPokemonsEvent>((event, emit) async {
      emit(state.copyWith(status: PokemonStatus.loading));

      /// call the usecase instance
      final responseGetPokemons = await getPokemonsUsecase(NoParams());
      if (responseGetPokemons.isRight()) {
        final pokemonsList =
            (responseGetPokemons as Right).value as List<Pokemon>? ?? [];

        /// Checks if the pokemon is already captured
        for (var i = 0; i < pokemonsList.length; i++) {
          if (state.capturedPokemonsList
              .where((element) => element.id == pokemonsList[i].id)
              .isNotEmpty) {
            /// Mark the pokemon as captured in the pokemonsList
            pokemonsList[i].isCaptured = true;
          }
        }

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

    on<OnToggleCapturedPokemonEvent>((event, emit) async {
      emit(state.copyWith(status: PokemonStatus.loadingToggleCaptured));

      event.isCaptured
          ? {
              // update the isCaptured property in the state's pokemonsList
              state.pokemonsList
                  .firstWhere(
                    (pokemon) => pokemon.id == event.capturedPokemon.id,
                  )
                  .isCaptured = event.isCaptured,

              // inserts in the db the captured pokemon
              await insertCapturedPokemonUseCase(
                InsertCapturedPokemonParams(
                  capturedPokemon: event.capturedPokemon,
                ),
              ),

              // add the new capturedPokemon to the state's capturedPokemonsList
              state.capturedPokemonsList.add(event.capturedPokemon),

              //secure emit the new state
              secureEmit(
                state.copyWith(status: PokemonStatus.isCaptured),
              ),
            }
          : {
              // update the isCaptured property in the state's pokemonsList
              state.pokemonsList
                  .firstWhere(
                    (pokemon) => pokemon.id == event.capturedPokemon.id,
                  )
                  .isCaptured = event.isCaptured,

              // remove of the db the captured pokemon
              await removeCapturedPokemonUseCase(
                RemoveCapturedPokemonParams(
                  capturedPokemon: event.capturedPokemon,
                ),
              ),

              // remove the new capturedPokemon to the state's capturedPokemonsList
              state.capturedPokemonsList.removeWhere(
                (element) => element.id == event.capturedPokemon.id,
              ),

              //secure emit the new state
              secureEmit(
                state.copyWith(status: PokemonStatus.isNotCaptured),
              ),
            };
    });

    on<OnLoadCapturedPokemonsEvent>((event, emit) async {
      emit(state.copyWith(status: PokemonStatus.loading));

      final responseGetCapturedPokemonsList =
          await getCapturedPokemonsUsecase(NoParams());
      if (responseGetCapturedPokemonsList.isRight()) {
        final capturedPokemonsList =
            (responseGetCapturedPokemonsList as Right).value as List<Pokemon>?;
        secureEmit(
          state.copyWith(
            status: PokemonStatus.successLoadCaptured,
            capturedPokemonsList: capturedPokemonsList,
          ),
        );
      } else {
        final failure =
            (responseGetCapturedPokemonsList as Left).value as Failure;
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

  ///
  final InsertCapturedPokemonUseCase insertCapturedPokemonUseCase;

  ///
  final RemoveCapturedPokemonUseCase removeCapturedPokemonUseCase;

  ///
  final GetCapturedPokemonsUsecase getCapturedPokemonsUsecase;
}
