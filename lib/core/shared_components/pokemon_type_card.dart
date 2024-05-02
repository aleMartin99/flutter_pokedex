import 'package:flutter/material.dart';
import 'package:flutter_pokedex/core/constants/pokemon_types.dart';

class PokemonTypeCard extends StatelessWidget {
  const PokemonTypeCard(
    this.type, {
    super.key,
    this.large = false,
    this.colored = false,
  });

  final PokemonTypes type;
  final bool large;
  final bool colored;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: large ? 19 : 12,
          vertical: large ? 6 : 4,
        ),
        decoration: ShapeDecoration(
          shape: const StadiumBorder(),
          color:
              (colored ? type.color : Theme.of(context).colorScheme.background)
                  .withOpacity(0.3),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              type.displayName,
              textScaler: TextScaler.noScaling,
              style: TextStyle(
                fontSize: large ? 12 : 8,
                height: 0.8,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(width: 5),
          ],
        ),
      ),
    );
  }
}
