import 'package:flutter_pokedex/data/adapters/isar_pokemon.dart';
import 'package:flutter_pokedex/domain/entities/pokemon.dart';

/// Method to convert from entity to dbAdapter
IsarPokemon pokemonToDBAdapter(Pokemon pokemon) {
  var isarPokemonAux = IsarPokemon();
  isarPokemonAux
    ..id = pokemon.id
    ..name = pokemon.name
    ..height = pokemon.height
    ..weight = pokemon.weight
    ..stats = pokemon.stats!
        .map(
          (e) => IsarStat()
            ..baseStat = e.baseStat
            ..statName = e.statName,
        )
        .toList()
    ..types = pokemon.types!
        .map(
          (e) => IsarPokemonTypes()
            ..color = e.color.toString()
            ..displayName = e.displayName,
        )
        .toList()
    ..image = pokemon.image
    ..livePreview = pokemon.livePreview;
  return isarPokemonAux;
}
