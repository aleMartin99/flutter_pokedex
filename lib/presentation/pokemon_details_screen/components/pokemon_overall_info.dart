import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/core/constants/image_constants.dart';
import 'package:flutter_pokedex/core/shared_components/app_bar.dart';
import 'package:flutter_pokedex/core/shared_components/pokemon_type_card.dart';
import 'package:flutter_pokedex/domain/entities/pokemon.dart';
import 'package:flutter_pokedex/presentation/pokedex_screen/components/pokemon_image.dart';
import 'package:flutter_pokedex/presentation/pokedex_screen/pokemon_bloc/pokemon_bloc.dart';
import 'package:flutter_pokedex/presentation/pokemon_details_screen/components/animated_fade.dart';
import 'package:flutter_pokedex/presentation/pokemon_details_screen/state_provider.dart';

class PokemonOverallInfo extends StatefulWidget {
  const PokemonOverallInfo({required this.pokemon});

  final Pokemon pokemon;

  @override
  _PokemonOverallInfoState createState() => _PokemonOverallInfoState();
}

class _PokemonOverallInfoState extends State<PokemonOverallInfo>
    with TickerProviderStateMixin {
  late AnimationController _horizontalSlideController;

  PokemonBloc get pokemonBloc => context.read<PokemonBloc>();
  AnimationController get slideController =>
      PokemonInfoStateProvider.of(context).slideController;
  AnimationController get rotateController =>
      PokemonInfoStateProvider.of(context).rotateController;

  Animation<double> get textFadeAnimation =>
      Tween(begin: 1.0, end: 0.0).animate(slideController);
  Animation<double> get sliderFadeAnimation =>
      Tween(begin: 1.0, end: 0.0).animate(CurvedAnimation(
        parent: slideController,
        curve: const Interval(0.0, 0.5, curve: Curves.ease),
      ));

  @override
  void initState() {
    _horizontalSlideController = AnimationController(
      vsync: this,
      duration: const Duration(microseconds: 300),
    )..forward();

    super.initState();
  }

  @override
  void dispose() {
    _horizontalSlideController.dispose();
    slideController.dispose();
    rotateController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.06,
        ),
        _buildAppBarButtons(widget.pokemon),
        const SizedBox(height: 9),
        _buildPokemonName(widget.pokemon),
        const SizedBox(height: 9),
        _buildPokemonTypes(widget.pokemon),
        const SizedBox(height: 25),
        _buildPokemonImage(),
      ],
    );
  }

  Widget _buildPokemonName(Pokemon pokemon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 26),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            pokemon.name!,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 28,
            ),
          ),
          Text(
            '#${pokemon.id}',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBarButtons(Pokemon pokemon) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(CupertinoIcons.left_chevron),
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Image(
              image: AssetImage(
                pokemon.isCaught
                    ? ImageConstants.capturedIcon
                    : ImageConstants.notCapturedIcon,
              ),
              height: pokemon.isCaught ? 30 : 25,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPokemonTypes(Pokemon pokemon) {
    return AnimatedFade(
      animation: textFadeAnimation,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: pokemon.types!
                    .take(3)
                    .map((type) => PokemonTypeCard(type, large: true))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPokemonImage() {
    final screenSize = MediaQuery.sizeOf(context);
    final sliderHeight = screenSize.height * 0.24;
    final pokeballSize = screenSize.height * 0.24;
    final pokemonSize = screenSize.height * 0.2;

    return AnimatedFade(
      animation: sliderFadeAnimation,
      child: SizedBox(
        width: screenSize.width,
        height: sliderHeight,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Align(
              alignment: Alignment.bottomCenter,
              child: RotationTransition(
                turns: rotateController,
                child: Image(
                  image: const AssetImage(ImageConstants.pokeball),
                  width: pokeballSize,
                  height: pokeballSize,
                  color: Colors.white.withOpacity(0.12),
                ),
              ),
            ),
            PokemonImage(
              pokemon: widget.pokemon,
              size: Size.square(pokemonSize),
              padding: const EdgeInsets.symmetric(
                vertical: 5,
              ),
              // tintColor: selected ? null : Colors.black26,
              // useHero: selected,
            ),
          ],
        ),
      ),
    );
  }
}
