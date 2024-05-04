// ignore_for_file: cascade_invocations

import 'package:flutter_pokedex/domain/entities/pokemon.dart';

/// Order the pokemon list by the main type
List<Pokemon> orderByType(List<Pokemon> pokemonList) {
  final orderedPokemonsList = <Pokemon>[];
  orderedPokemonsList.addAll(pokemonList);
  orderedPokemonsList.sort((a, b) =>
      a.types!.first.displayName.compareTo(b.types!.first.displayName));
  return orderedPokemonsList;
}
