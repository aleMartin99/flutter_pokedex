// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_pokedex/data/models/local_models/db_pokemon/isar_pokemon.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

/// IsarHelper class
class IsarHelper {
  late Isar _instance;

  ///
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
}
