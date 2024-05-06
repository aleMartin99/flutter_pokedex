import 'package:flutter/material.dart';
import 'package:flutter_pokedex/core/constants/constants_exports.dart';
import 'package:flutter_pokedex/domain/entities/pokemon.dart';

/// method to get the Predominant color of pokemons
Color getPredominantPoKeTypeColor(List<Pokemon> capturedPokemons) {
  final typeCount = <PokemonTypes, int>{};

  for (final pokemon in capturedPokemons) {
    if (pokemon.types != null && pokemon.types!.isNotEmpty) {
      final type = pokemon.types!.first;

      /// only considering the first type
      if (typeCount.containsKey(type)) {
        typeCount[type] = typeCount[type]! + 1;
      } else {
        typeCount[type] = 1;
      }
    }
  }

  if (typeCount.isNotEmpty) {
    /// find the most common type
    final highestFrequency = typeCount.values.reduce((a, b) => a > b ? a : b);
    final mostCommonTypes = typeCount.entries
        .where((entry) => entry.value == highestFrequency)
        .toList();

    /// returns the color associated with the most common type
    /// or the default if there is a tie
    if (mostCommonTypes.length == 1) {
      return mostCommonTypes.first.key.color;
    } else {
      // returns the default color if there is not a predominant pokemon type
      return AppColors.primary;
    }
  } else {
    // returns the default color if there is not a predominant pokemon type
    return AppColors.primary;
  }
}
