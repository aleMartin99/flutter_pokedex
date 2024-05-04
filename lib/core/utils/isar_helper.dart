// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/foundation.dart';
import 'package:flutter_pokedex/core/services/pokemon_entity_to_db_adapter_service.dart';
import 'package:flutter_pokedex/data/adapters/isar_pokemon.dart';
import 'package:flutter_pokedex/domain/entities/pokemon.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarHelper {
  late Isar _instance;

  Isar get instance => _instance;

  /// Initializes the isar database.
  ///
  /// This method needs to be called before accessing any isar-specific APIs.
  Future<void> init() async {
    if (Isar.instanceNames.isNotEmpty) return;
    final dir = await getApplicationDocumentsDirectory();
    _instance = await Isar.open(
      [IsarPokemonSchema],
      directory: dir.path,
    );
  }

//TODO add to localDatasource
  insertCapturedPokemon(Pokemon capturedPokemon) async {
    late int id;
    await instance.writeTxn(() async {
      id = await instance.isarPokemons.put(pokemonToDBAdapter(capturedPokemon));
    });
    if (kDebugMode) {
      print('id from object created $id');
    }
    return id;
  }

//TODO add to localDatasource
  Future<void> removeCapturedPokemon(Pokemon capturedPokemon) async {
    await instance.writeTxn(() async {
      final isDeleted = await instance.isarPokemons.delete(capturedPokemon.id!);
      if (kDebugMode) {
        print('response for delete $isDeleted');
      }
    });
  }

//TODO add to localDatasource
  ///
  Future<List<Pokemon>> getCapturedPokemons() async {
    final capturedPokemonsCollection = instance.collection<IsarPokemon>();

    final capturedDBPokemons =
        await capturedPokemonsCollection.where().findAll();

    final capturedPokemonsList = capturedDBPokemons
        .map(
          Pokemon.fromDBAdapter,
        )
        .toList();

    return capturedPokemonsList;
  }
}
