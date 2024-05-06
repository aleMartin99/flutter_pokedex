import 'package:flutter/material.dart';
import 'package:flutter_pokedex/core/constants/constants_exports.dart';

/// Pokeball Loading indicator
class PokeBallLoadingIndicator extends StatelessWidget {
  ///
  const PokeBallLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Image(
        // image: GifConstants.pokeball_loader,
        image: NetworkImage(ImageConstants.pokeballGif),
        fit: BoxFit.contain,
      ),
    );
  }
}
