import 'package:flutter/material.dart';
import 'package:flutter_pokedex/domain/entities/pokemon.dart';
import 'package:flutter_pokedex/presentation/pokemon_details_screen/pokemon_details_screen_exports.dart';

/// PokemonDetails screen
class PokemonDetailsScreen extends StatelessWidget {
  ///
  const PokemonDetailsScreen({required this.pokemon, super.key});

  ///
  final Pokemon pokemon;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PokemonDetailsBody(
        pokemon: pokemon,
      ),
    );
  }
}
