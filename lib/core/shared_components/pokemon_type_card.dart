import 'package:flutter/material.dart';
import 'package:flutter_pokedex/core/constants/constants_exports.dart';

/// Pokemon Type card class
class PokemonTypeCard extends StatelessWidget {
  ///
  const PokemonTypeCard(
    this.type, {
    super.key,
    this.large = false,
  });

  /// type
  final PokemonTypes type;

  /// flag to condition the style in the pokedex list or the details
  final bool large;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: large ? 19 : 13,
          vertical: large ? 6 : 4,
        ),
        decoration: const ShapeDecoration(
          shape: StadiumBorder(),
          color: Colors.white24,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              type.displayName,
              textScaler: TextScaler.noScaling,
              style: TextStyle(
                fontSize: large ? 12 : 8,
                height: 0.9,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
