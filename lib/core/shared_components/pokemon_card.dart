import 'package:flutter/material.dart';
import 'package:flutter_pokedex/core/constants/constants_exports.dart';
import 'package:flutter_pokedex/core/shared_components/shared_components_exports.dart';
import 'package:flutter_pokedex/domain/entities/pokemon.dart';
import 'package:flutter_pokedex/presentation/pokedex_screen/pokedex_screen_exports.dart';

/// PokemonCard class
class PokemonCard extends StatelessWidget {
  ///
  const PokemonCard(
    this.pokemon, {
    super.key,
    this.onPress,
  });
  static const double _pokeballFraction = 0.75;
  static const double _pokemonFraction = 0.76;

  ///
  final Pokemon pokemon;

  ///
  final void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constrains) {
        final itemHeight = constrains.maxHeight;

        return Container(
          decoration: BoxDecoration(
            color: pokemon.color,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: pokemon.color.withOpacity(0.4),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Material(
              color: pokemon.color,
              child: InkWell(
                onTap: onPress,
                splashColor: Colors.white10,
                highlightColor: Colors.white10,
                child: Stack(
                  children: [
                    _buildPokeballDecoration(height: itemHeight),
                    _buildPokemon(height: itemHeight),
                    _buildPokemonNumber(),
                    _CardContent(pokemon),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPokeballDecoration({required double height}) {
    final pokeballSize = height * _pokeballFraction;

    return Positioned(
      bottom: -height * 0.13,
      right: -height * 0.03,
      child: Image(
        image: const AssetImage(ImageConstants.pokeball),
        width: pokeballSize,
        height: pokeballSize,
        color: Colors.white.withOpacity(0.14),
      ),
    );
  }

  Widget _buildPokemon({required double height}) {
    final pokemonSize = height * _pokemonFraction;

    return Positioned(
      bottom: -2,
      right: 2,
      child: PokemonImage(
        size: Size.square(pokemonSize),
        pokemon: pokemon,
      ),
    );
  }

  Widget _buildPokemonNumber() {
    return Positioned(
      top: 10,
      right: 14,
      child: Text(
        '#${pokemon.id}',
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black12,
        ),
      ),
    );
  }
}

class _CardContent extends StatelessWidget {
  const _CardContent(this.pokemon);
  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w900,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Hero(
                tag: pokemon.id ?? pokemon.name ?? 'Pokemon Name',
                child: Text(
                  pokemon.name!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.5,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ..._buildTypes(context),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTypes(BuildContext context) {
    return pokemon.types!
        .take(2)
        .map(
          (type) => Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: PokemonTypeCard(type),
          ),
        )
        .toList();
  }
}
