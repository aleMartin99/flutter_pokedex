// ignore_for_file: unnecessary_await_in_return, avoid_dynamic_calls

import 'dart:async';

import 'package:flutter_pokedex/core/errors/failures.dart';
import 'package:flutter_pokedex/core/utils/utils_exports.dart';
import 'package:flutter_pokedex/data/datasources/local_datasource/local_datasource_exports.dart';
import 'package:flutter_pokedex/data/models/local_models/db_pokemon/isar_pokemon.dart';
import 'package:fpdart/fpdart.dart';
import 'package:isar/isar.dart';

/// PokemonDatasource implementation
class CapturedPokemonDatasource implements ICapturedPokemonDatasource {
  ///
  CapturedPokemonDatasource({required this.isarHelper});

  ///
  IsarHelper isarHelper;

  /// inserts the captured pokemon into the db
  @override
  Future<Either<Failure, Unit>> insertCapturedPokemon(
    IsarPokemon capturedPokemon,
  ) async {
    try {
      await isarHelper.instance.writeTxn(() async {
        await isarHelper.instance.isarPokemons.put(capturedPokemon);
      });
      return right(unit);
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  /// remove the captured pokemon into the db
  @override
  Future<Either<Failure, Unit>> removeCapturedPokemon(
    IsarPokemon capturedPokemon,
  ) async {
    try {
      await isarHelper.instance.writeTxn(() async {
        await isarHelper.instance.isarPokemons.delete(capturedPokemon.id!);
      });
      return right(unit);
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }

  /// get the captured pokemons from db
  @override
  Future<Either<Failure, List<IsarPokemon>>> getCapturedPokemons() async {
    try {
      final capturedPokemonsCollection =
          isarHelper.instance.collection<IsarPokemon>();

      final capturedDBPokemons =
          await capturedPokemonsCollection.where().findAll();

      return right(capturedDBPokemons);
    } catch (e) {
      return left(UnexpectedFailure(message: e.toString()));
    }
  }
}
