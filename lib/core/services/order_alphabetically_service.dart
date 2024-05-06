// ignore_for_file: cascade_invocations

import 'package:flutter_pokedex/domain/entities/pokemon.dart';

/// orderAlphabetically a list of pokemons
List<Pokemon> orderAlphabetically(List<Pokemon> pokemonList) {
  final orderedPokemonsList = <Pokemon>[];
  orderedPokemonsList.addAll(pokemonList);
  orderedPokemonsList.sort((a, b) => a.name!.compareTo(b.name!));
  return orderedPokemonsList;
}
