part of 'pokemon_details_body.dart';

/// PokemonDetailsDecoration
class PokemonDetailsDecoration extends StatelessWidget {
  ///
  const PokemonDetailsDecoration({super.key});

  ///
  static const Size size = Size.square(144);

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: pi * 5 / 12,
      child: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: const Alignment(-0.2, -0.2),
            end: const Alignment(1.5, -0.3),
            colors: [
              Colors.white.withOpacity(0.3),
              Colors.white.withOpacity(0),
            ],
          ),
        ),
      ),
    );
  }
}

///
class BackgroundDecoration extends StatefulWidget {
  ///
  const BackgroundDecoration({required this.pokemon, super.key});

  ///
  final Pokemon pokemon;

  @override
  State<BackgroundDecoration> createState() => _BackgroundDecorationState();
}

class _BackgroundDecorationState extends State<BackgroundDecoration> {
  Animation<double> get slideController =>
      PokemonInfoStateProvider.of(context).slideController;
  Animation<double> get rotateController =>
      PokemonInfoStateProvider.of(context).rotateController;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildBackground(widget.pokemon.color),
        _buildBoxDecoration(),
        _buildAppBarPokeballDecoration(),
      ],
    );
  }

  Widget _buildBackground(Color color) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      constraints: const BoxConstraints.expand(),
      color: color,
    );
  }

  Widget _buildBoxDecoration() {
    return Positioned(
      top: -PokemonDetailsDecoration.size.height * 0.4,
      left: -PokemonDetailsDecoration.size.width * 0.4,
      child: const PokemonDetailsDecoration(),
    );
  }

  Widget _buildAppBarPokeballDecoration() {
    final screenSize = MediaQuery.sizeOf(context);
    final safeAreaTop = MediaQuery.paddingOf(context).top;

    final pokeSize = screenSize.width * 0.5;
    final appBarHeight = AppBar().preferredSize.height;
    const iconButtonPadding = 24;
    final iconSize = IconTheme.of(context).size ?? 0;

    final pokeballTopMargin = -(pokeSize / 2 - safeAreaTop - appBarHeight / 2);
    final pokeballRightMargin =
        -(pokeSize / 2 - iconButtonPadding - iconSize / 2);

    return Positioned(
      top: pokeballTopMargin,
      right: pokeballRightMargin,
      child: IgnorePointer(
        child: AnimatedFade(
          animation: slideController,
          child: RotationTransition(
            turns: rotateController,
            child: Image(
              image: const AssetImage(ImageConstants.pokeball),
              width: pokeSize,
              height: pokeSize,
              color: Colors.white24,
            ),
          ),
        ),
      ),
    );
  }
}
