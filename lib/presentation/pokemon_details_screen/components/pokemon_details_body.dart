import 'package:flutter/material.dart' hide AnimatedSlide;
import 'package:flutter_pokedex/domain/entities/pokemon.dart';
import 'package:flutter_pokedex/presentation/pokemon_details_screen/pokemon_details_screen_exports.dart';

///Pokemon details body class
class PokemonDetailsBody extends StatefulWidget {
  ///
  const PokemonDetailsBody({
    required this.pokemon,
    super.key,
  });

  ///
  final Pokemon pokemon;

  @override
  PokemonInfoState createState() => PokemonInfoState();
}

///
class PokemonInfoState extends State<PokemonDetailsBody>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late AnimationController _rotateController;

  @override
  void initState() {
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 5000),
    )..repeat();

    super.initState();
  }

  @override
  void dispose() {
    _slideController.dispose();
    _rotateController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PokemonInfoStateProvider(
      slideController: _slideController,
      rotateController: _rotateController,
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            BackgroundDecoration(pokemon: widget.pokemon),
            PokemonInfoCard(
              pokemon: widget.pokemon,
            ),
            PokemonOverallInfo(
              pokemon: widget.pokemon,
            ),
          ],
        ),
      ),
    );
  }
}
