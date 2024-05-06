// ignore_for_file: unnecessary_lambdas

import 'dart:async';
import 'package:flutter_pokedex/core/utils/utils_exports.dart';
import 'package:flutter_pokedex/data/datasources/local_datasource/local_datasource_exports.dart';
import 'package:flutter_pokedex/data/datasources/remote_datasource/ipokemon_datasource.dart';
import 'package:flutter_pokedex/data/datasources/remote_datasource/pokemon_datasource/pokemon_datasource.dart';
import 'package:flutter_pokedex/data/repositories/captured_pokemon_repository.dart';
import 'package:flutter_pokedex/data/repositories/pokemon_repository.dart';
import 'package:flutter_pokedex/domain/repositories/ipokemon_local_repository.dart';
import 'package:flutter_pokedex/domain/repositories/ipokemon_remote_repository.dart';
import 'package:flutter_pokedex/domain/usecases/get_captured_pokemons/get_captured_pokemons_usecase.dart';
import 'package:flutter_pokedex/domain/usecases/get_pokemons/get_pokemons_usecase.dart';
import 'package:flutter_pokedex/domain/usecases/insert_captured_pokemon/insert_captured_pokemon_usecase.dart';
import 'package:flutter_pokedex/domain/usecases/remove_captured_pokemon/remove_captured_pokemon_usecase.dart';
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
    ..registerLazySingleton<ICapturedPokemonDatasource>(
      () => CapturedPokemonDatasource(isarHelper: sl<IsarHelper>()),
    )
    ..registerLazySingleton<IPokemonRemoteRepository>(
      () => PokemonRepository(
        sl<IPokemonDatasource>(),
      ),
    )
    ..registerLazySingleton<IPokemonLocalRepository>(
      () => CapturedPokemonRepository(
        sl<ICapturedPokemonDatasource>(),
      ),
    )
    ..registerLazySingleton<GetPokemonsUsecase>(
      () => GetPokemonsUsecase(
        getPokemons: sl<IPokemonRemoteRepository>().getPokemons,
      ),
    )
    ..registerLazySingleton<GetCapturedPokemonsUsecase>(
      () => GetCapturedPokemonsUsecase(
        getCapturedPokemons: sl<IPokemonLocalRepository>().getCapturedPokemons,
      ),
    )
    ..registerLazySingleton<InsertCapturedPokemonUseCase>(
      () => InsertCapturedPokemonUseCase(
        insertCapturedPokemon:
            sl<IPokemonLocalRepository>().insertCapturedPokemon,
      ),
    )
    ..registerLazySingleton<RemoveCapturedPokemonUseCase>(
      () => RemoveCapturedPokemonUseCase(
        removeCapturedPokemon:
            sl<IPokemonLocalRepository>().removeCapturedPokemon,
      ),
    )
    ..registerLazySingleton<PokemonBloc>(
      () => PokemonBloc(
        getPokemonsUsecase: sl<GetPokemonsUsecase>(),
        getCapturedPokemonsUsecase: sl<GetCapturedPokemonsUsecase>(),
        insertCapturedPokemonUseCase: sl<InsertCapturedPokemonUseCase>(),
        removeCapturedPokemonUseCase: sl<RemoveCapturedPokemonUseCase>(),
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

  /// Initialize the isar db
  await sl<IsarHelper>().init();
}
