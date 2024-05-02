import 'dart:ui';

import 'package:flutter_pokedex/core/theme/colors.dart';

enum PokemonTypes {
  grass('Grass', AppColors.lightGreen),
  poison('Poison', AppColors.lightPurple),
  fire('Fire', AppColors.lightRed),
  flying('Flying', AppColors.lilac),
  water('Water', AppColors.lightBlue),
  bug('Bug', AppColors.lightTeal),
  normal('Normal', AppColors.beige),
  electric('Electric', AppColors.lightYellow),
  ground('Ground', AppColors.darkBrown),
  fairy('Fairy', AppColors.pink),
  fighting('Fighting', AppColors.red),
  psychic('Psychic', AppColors.lightPink),
  rock('Rock', AppColors.lightBrown),
  steel('Steel', AppColors.grey),
  ice('Ice', AppColors.lightCyan),
  ghost('Ghost', AppColors.purple),
  dragon('Dragon', AppColors.violet),
  dark('Dark', AppColors.black),
  monster('Monster', AppColors.lightBlue),
  unknown('Unknown', AppColors.lightBlue);

  final String displayName;
  final Color color;

  const PokemonTypes(this.displayName, this.color);

  static PokemonTypes parse(String rawValue) => values.firstWhere(
        (e) => e.name == rawValue.toLowerCase(),
        orElse: () => unknown,
      );
}
