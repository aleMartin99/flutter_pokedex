import 'package:flutter/material.dart';
import 'package:flutter_pokedex/domain/entities/pokemon.dart';
import 'package:flutter_pokedex/presentation/pokemon_details_screen/components/pokemon_details_body.dart';

/// PokemonDetails screen
class PokemonDetailsScreen extends StatelessWidget {
  ///
  const PokemonDetailsScreen({super.key, required this.pokemon});

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
