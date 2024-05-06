import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_pokedex/core/constants/constants_exports.dart';

/// Pokeball custom scaffold
class PokeballScaffold extends Scaffold {
  ///
  PokeballScaffold({
    super.key,
    Widget? body,
  }) : super(
          body: Stack(
            fit: StackFit.expand,
            children: [
              const PositionedPokeball(),
              if (body != null) body,
            ],
          ),
        );
}

///PositionedPokeball class
class PositionedPokeball extends StatelessWidget {
  ///
  const PositionedPokeball({
    super.key,
    this.widthFraction = 0.664,
    this.maxSize = 250,
  });

  ///
  final double widthFraction;

  ///
  final double maxSize;

  @override
  Widget build(BuildContext context) {
    final safeAreaTop = MediaQuery.paddingOf(context).top;
    final pokeballSize =
        min(MediaQuery.sizeOf(context).width * widthFraction, maxSize);
    const iconButtonPadding = 20;
    final iconSize = IconTheme.of(context).size ?? 0;

    final pokeballTopMargin =
        -(pokeballSize / 2 - safeAreaTop - kToolbarHeight / 2);
    final pokeballRightMargin =
        -(pokeballSize / 2 - iconButtonPadding - iconSize / 2);

    return Positioned(
      top: pokeballTopMargin,
      right: pokeballRightMargin,
      child: Image(
        image: const AssetImage(ImageConstants.pokeball),
        width: pokeballSize,
        height: pokeballSize,
        color: Theme.of(context).colorScheme.primary.withOpacity(0.25),
      ),
    );
  }
}
