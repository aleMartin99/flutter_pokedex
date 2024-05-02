import 'package:flutter_pokedex/data/models/pokemon_model/pokemon_model.dart';
import 'package:flutter_pokedex/data/models/pokemon_model/stat.dart';

/// Pokemon entity
class Pokemon {
  ///
  Pokemon({
    required this.isCaught,
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
      name: pokemonModel.name,
      height: pokemonModel.height,
      image: pokemonModel.sprites!.image,
      livePreview: pokemonModel.sprites!.livePreview,

      /// By default is false because there is no info about it in the api
      isCaught: false,
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
  final List<Type>? types;

  /// Is caught
  bool isCaught;
}
