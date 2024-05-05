import 'package:flutter/material.dart';
import 'package:flutter_pokedex/core/constants/pokemon_types.dart';
import 'package:flutter_pokedex/core/theme/colors.dart';
import 'package:flutter_pokedex/domain/entities/pokemon.dart';

///
Color getPredominantPoKeTypeColor(List<Pokemon> capturedPokemons) {
  Map<PokemonTypes, int> typeCount = {};

  for (var pokemon in capturedPokemons) {
    if (pokemon.types != null && pokemon.types!.isNotEmpty) {
      var type = pokemon.types!.first; // Solo se considera el primer tipo
      if (typeCount.containsKey(type)) {
        typeCount[type] = typeCount[type]! + 1;
      } else {
        typeCount[type] = 1;
      }
    }
  }

  if (typeCount.isNotEmpty) {
    // Encontrar el tipo más común y comprobar si hay empates
    int highestFrequency = typeCount.values.reduce((a, b) => a > b ? a : b);
    var mostCommonTypes = typeCount.entries
        .where((entry) => entry.value == highestFrequency)
        .toList();

    // Devolver el color asociado al tipo más común o el color por defecto si hay empate
    if (mostCommonTypes.length == 1) {
      return mostCommonTypes.first.key.color;
    } else {
      // Retorno un color por defecto si no hay pokémon capturados
      return AppColors.primary;
    }
  } else {
    // Retorno un color por defecto si no hay pokémon capturados
    return AppColors.primary;
  }
}
