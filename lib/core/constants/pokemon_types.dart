// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_pokedex/core/constants/constants_exports.dart';

enum PokemonTypes {
  bug('Bug', AppColors.bug),
  dark('Dark', AppColors.dark),
  dragon('Dragon', AppColors.dragon),
  electric('Electric', AppColors.electric),
  fairy('Fairy', AppColors.fairy),
  fighting('Fighting', AppColors.fighting),
  fire('Fire', AppColors.fire),
  flying('Flying', AppColors.flying),
  ghost('Ghost', AppColors.ghost),
  grass('Grass', AppColors.grass),
  ground('Ground', AppColors.ground),
  ice('Ice', AppColors.ice),
  normal('Normal', AppColors.normal),
  poison('Poison', AppColors.poison),
  psychic('Psychic', AppColors.psychic),
  rock('Rock', AppColors.rock),
  steel('Steel', AppColors.steel),
  water('Water', AppColors.water),
  unknown('Unknown', AppColors.lightBlue);

  const PokemonTypes(this.displayName, this.color);
  final String displayName;
  final Color color;

  static PokemonTypes parse(String rawValue) => values.firstWhere(
        (e) => e.name == rawValue.toLowerCase(),
        orElse: () => unknown,
      );
}
