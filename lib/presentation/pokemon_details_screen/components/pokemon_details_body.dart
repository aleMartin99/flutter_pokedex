import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart' hide AnimatedSlide;
import 'package:flutter_pokedex/core/constants/image_constants.dart';
import 'package:flutter_pokedex/domain/entities/pokemon.dart';

import 'package:flutter_pokedex/presentation/pokemon_details_screen/components/animated_fade.dart';
import 'package:flutter_pokedex/presentation/pokemon_details_screen/components/pokemon_info_card.dart';
import 'package:flutter_pokedex/presentation/pokemon_details_screen/components/pokemon_overall_info.dart';
import 'package:flutter_pokedex/presentation/pokemon_details_screen/state_provider.dart';

part 'pokemon_details_decoration.dart';
part 'pokemon_info_card_about.dart';

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
            _BackgroundDecoration(pokemon: widget.pokemon),
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
