import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:flutter_pokedex/data/models/pokemon_model/sprites.dart';
import 'package:flutter_pokedex/data/models/pokemon_model/stat.dart';
import 'package:flutter_pokedex/data/models/pokemon_model/type.dart';

/// Pokemon Model.
class PokemonModel extends Equatable {
  ///
  const PokemonModel({
    this.id,
    this.name,
    this.height,
    this.weight,
    this.sprites,
    this.stats,
    this.types,
  });

  ///PokemonModel's fromMap method.
  factory PokemonModel.fromMap(Map<String, dynamic> data) => PokemonModel(
        id: data['id'] as int?,
        name: data['name'] as String?,
        height: data['height'] as int?,
        weight: data['weight'] as int?,
        sprites: data['sprites'] == null
            ? null
            : Sprites.fromMap(data['sprites'] as Map<String, dynamic>),
        stats: (data['stats'] as List<dynamic>?)
            ?.map((e) => Stat.fromMap(e as Map<String, dynamic>))
            .toList(),
        types: (data['types'] as List<dynamic>?)
            ?.map((e) => Type.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PokemonModel].
  factory PokemonModel.fromJson(Map<String, dynamic> data) {
    return PokemonModel.fromMap(data);
  }

  /// The Pokémon's identifier.
  final int? id;

  /// The Pokémon's name.
  final String? name;

  /// The height of this Pokémon in decimetres.
  final int? height;

  /// The weight of this Pokémon in hectograms.
  final int? weight;

  /// A set of sprites used to depict this Pokémon in the game.
  final Sprites? sprites;

  /// A list of base stat values for this Pokémon.
  final List<Stat>? stats;

  /// A list of types this Pokémon has.
  final List<Type>? types;

  @override
  List<Object?> get props {
    return [
      id,
      name,
      height,
      weight,
      sprites,
      stats,
      types,
    ];
  }
}
