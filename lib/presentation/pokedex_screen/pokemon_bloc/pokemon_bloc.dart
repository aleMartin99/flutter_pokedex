// ignore_for_file: collection_methods_unrelated_type, inference_failure_on_untyped_parameter, lines_longer_than_80_chars, unnecessary_statements

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/core/errors/failures.dart';
import 'package:flutter_pokedex/core/utils/isar_helper.dart';
import 'package:flutter_pokedex/core/utils/utils_exports.dart';
import 'package:flutter_pokedex/domain/entities/pokemon.dart';
import 'package:flutter_pokedex/domain/usecases/get_pokemons/get_pokemons_usecase.dart';
import 'package:flutter_pokedex/main.dart';
import 'package:fpdart/fpdart.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';
part 'pokemon_status.dart';

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
//TODO error aqui al acceder al firstwhere y no hay ninguno q cumpla la condicion
      event.isCaptured
          //TODO call save to db useCase
          ? {
              state.pokemonsList
                  .firstWhere(
                    (pokemon) => pokemon.id == event.capturedPokemon.id,
                  )
                  .isCaptured = event.isCaptured,
              await isarDBHelper.insertCapturedPokemon(event.capturedPokemon),
              state.capturedPokemonsList.add(event.capturedPokemon),
              secureEmit(
                state.copyWith(status: PokemonStatus.isCaptured),
              ),
            }

          //TODO call remove from db useCase
          : {
              await isarDBHelper.removeCapturedPokemon(event.capturedPokemon),
              state.pokemonsList
                  .firstWhere(
                    (pokemon) => pokemon.id == event.capturedPokemon.id,
                  )
                  .isCaptured = event.isCaptured,
              state.capturedPokemonsList.removeWhere(
                (element) => element.id == event.capturedPokemon.id,
              ),
              secureEmit(
                state.copyWith(status: PokemonStatus.isNotCaptured),
              )
            };
    });

    on<OnLoadCapturedPokemonsEvent>((event, emit) async {
      emit(state.copyWith(status: PokemonStatus.loading));

      final capturedPokemonsList = await isarDBHelper.getCapturedPokemons();

      secureEmit(
        state.copyWith(
          status: PokemonStatus.successLoadCaptured,
          capturedPokemonsList: capturedPokemonsList,
        ),
      );
    });
  }

  ///
  final GetPokemonsUsecase getPokemonsUsecase;

  ///
  var isarDBHelper = sl<IsarHelper>();
}
