// ignore_for_file: public_member_api_docs

import 'package:isar/isar.dart';

part 'isar_pokemon.g.dart';

/// IsarPokemon class
@collection
class IsarPokemon {
  Id? id;
  String? name;
  int? height;
  int? weight;
  String? image;
  String? livePreview;
  List<IsarStat>? stats;
  List<IsarPokemonTypes>? types;
  String? color;
}

@embedded
class IsarStat {
  int? baseStat;
  String? statName;
}

@embedded
class IsarPokemonTypes {
  String? displayName;
  String? color;
}
