import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pokedex/core/shared_components/custom_scaffold.dart';
import 'package:flutter_pokedex/presentation/pokedex_screen/components/pokemon_grid.dart';

/// PokedexBody class
class PokedexBody extends StatefulWidget {
  ///
  const PokedexBody({super.key});

  @override
  State<PokedexBody> createState() => _PokedexBodyState();
}

class _PokedexBodyState extends State<PokedexBody> {
  @override
  Widget build(BuildContext context) {
    return PokeballScaffold(
      body: const Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: PokemonGrid(),
          ),
        ],
      ),
    );
  }
}
