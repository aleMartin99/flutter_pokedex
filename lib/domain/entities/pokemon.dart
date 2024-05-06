import 'package:flutter/material.dart';
import 'package:flutter_pokedex/core/constants/constants_exports.dart';
import 'package:flutter_pokedex/core/services/services_exports.dart';
import 'package:flutter_pokedex/data/models/local_models/db_pokemon/isar_pokemon.dart';
import 'package:flutter_pokedex/data/models/remote_models/remote_models_exports.dart';

/// Pokemon entity
class Pokemon {
  ///
  Pokemon({
    required this.isCaptured,
    this.id,
    this.name,
    this.height,
    this.weight,
    this.image,
    this.livePreview,
    this.stats,
    this.types,
  });

  /// Method to convert from model to entity
  factory Pokemon.fromModel(PokemonModel pokemonModel) {
    return Pokemon(
      id: pokemonModel.id,
      name: capitalizeFirstLetter(pokemonModel.name!),
      height: pokemonModel.height,
      weight: pokemonModel.weight,
      stats: pokemonModel.stats!
          .map(
            (e) => Stat(
              baseStat: e.baseStat,
              statName: capitalizeFirstLetter(e.statName!),
            ),
          )
          .toList(),
      types:
          pokemonModel.types!.map((e) => PokemonTypes.parse(e.type!)).toList(),
      image: pokemonModel.sprites!.image,
      livePreview: pokemonModel.sprites!.livePreview,

      /// By default is false because there is no info about it in the api
      isCaptured: false,
    );
  }

  /// Method to convert from dbAdapter to entity
  factory Pokemon.fromDBAdapter(IsarPokemon dbPokemon) {
    return Pokemon(
      id: dbPokemon.id,
      name: dbPokemon.name,
      height: dbPokemon.height,
      weight: dbPokemon.weight,
      stats: dbPokemon.stats!
          .map(
            (e) => Stat(
              baseStat: e.baseStat,
              statName: capitalizeFirstLetter(e.statName!),
            ),
          )
          .toList(),
      types: dbPokemon.types!
          .map((e) => PokemonTypes.parse(e.displayName!))
          .toList(),
      image: dbPokemon.image,
      livePreview: dbPokemon.livePreview,
      isCaptured: true,
    );
  }

  /// The Pokémon's identifier.
  final int? id;

  /// The Pokémon's name.
  final String? name;

  /// The height of this Pokémon in decimetres.
  final int? height;

  /// The weight of this Pokémon in hectograms.
  final int? weight;

  /// The Pokémon's image.
  final String? image;

  /// A Pokémon's live preview.
  final String? livePreview;

  /// A list of base stat values for this Pokémon.
  final List<Stat>? stats;

  /// A list of types this Pokémon has.
  final List<PokemonTypes>? types;

  /// The Pokémon's color based on first type.
  Color get color => types!.first.color;

  /// isCaptured
  bool isCaptured;
}
