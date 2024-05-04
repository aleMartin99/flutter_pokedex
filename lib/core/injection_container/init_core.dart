// ignore_for_file: unnecessary_lambdas

import 'dart:async';
import 'package:flutter_pokedex/core/utils/isar_helper.dart';
import 'package:flutter_pokedex/data/datasources/remote_datasource/ipokemon_datasource.dart';
import 'package:flutter_pokedex/data/datasources/remote_datasource/pokemon_datasource/pokemon_datasource.dart';
import 'package:flutter_pokedex/data/repositories/pokemon_repository.dart';
import 'package:flutter_pokedex/domain/repositories/ipokemon_repository.dart';
import 'package:flutter_pokedex/domain/usecases/get_pokemons/get_pokemons_usecase.dart';
import 'package:flutter_pokedex/presentation/captured_screen/filter_bloc/filter_bloc.dart';
import 'package:flutter_pokedex/presentation/pokedex_screen/pokemon_bloc/pokemon_bloc.dart';
import 'package:flutter_pokedex/presentation/pokedex_screen/search_bloc/search_bloc.dart';
import 'package:get_it/get_it.dart';

//Favors Dependency inversion and single responsibility principles

/// Initialize the app's core
FutureOr<void> initCore(GetIt sl) async {
  sl
    ..registerLazySingleton<IPokemonDatasource>(
      () => PokemonDatasource(),
    )
    ..registerLazySingleton<IPokemonRepository>(
      () => PokemonRepository(
        sl<IPokemonDatasource>(),
      ),
    )
    ..registerLazySingleton<GetPokemonsUsecase>(
      () => GetPokemonsUsecase(
        getPokemons: sl<IPokemonRepository>().getPokemons,
      ),
    )
    ..registerLazySingleton<PokemonBloc>(
      () => PokemonBloc(
        getPokemonsUsecase: sl<GetPokemonsUsecase>(),
      ),
    )
    ..registerLazySingleton<SearchBloc>(
      () => SearchBloc(),
    )
    ..registerLazySingleton<FilterBloc>(
      () => FilterBloc(),
    )
    ..registerLazySingleton<IsarHelper>(
      () => IsarHelper(),
    );
}
