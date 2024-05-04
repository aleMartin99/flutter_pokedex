import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pokedex/core/shared_components/custom_scaffold.dart';
import 'package:flutter_pokedex/presentation/captured_screen/components/capture_pokemon_grid.dart';

/// CapturedBody class
class CapturedBody extends StatefulWidget {
  ///
  const CapturedBody({super.key});

  @override
  State<CapturedBody> createState() => _CapturedBodyState();
}

class _CapturedBodyState extends State<CapturedBody> {
  @override
  Widget build(BuildContext context) {
    return PokeballScaffold(
      body: const Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: CapturedPokemonGrid(),
          ),
        ],
      ),
    );
  }
}
