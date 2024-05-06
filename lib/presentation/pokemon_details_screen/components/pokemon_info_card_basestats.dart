import 'package:flutter/material.dart';
import 'package:flutter_pokedex/core/constants/colors.dart';
import 'package:flutter_pokedex/data/models/remote_models/pokemon_model/stat.dart';
import 'package:flutter_pokedex/domain/entities/pokemon.dart';
import 'package:flutter_pokedex/presentation/pokemon_details_screen/components/progress.dart';
import 'package:flutter_pokedex/presentation/pokemon_details_screen/state_provider.dart';

///StatWidget class
class StatWidget extends StatelessWidget {
  const StatWidget({
    required this.animation,
    required this.label,
    required this.value,
    super.key,
    this.progress,
  });

  ///
  final Animation<double> animation;

  ///
  final String label;

  ///
  final double? progress;

  ///
  final num value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              color: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .color!
                  .withOpacity(0.6),
            ),
          ),
        ),
        Expanded(
          child: Text('$value'),
        ),
        Expanded(
          flex: 5,
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, widget) {
              final currentProgress = progress ?? value / 100;

              return ProgressBar(
                progress: animation.value * currentProgress,
                color: Theme.of(context).primaryColor,
                enableAnimation: animation.value == 1,
              );
            },
          ),
        ),
      ],
    );
  }
}

/// PokemonBaseStats class
class PokemonBaseStats extends StatefulWidget {
  ///
  const PokemonBaseStats(this.pokemon, {super.key});

  ///
  final Pokemon pokemon;

  @override
  State<PokemonBaseStats> createState() => _PokemonBaseStatsState();
}

class _PokemonBaseStatsState extends State<PokemonBaseStats>
    with SingleTickerProviderStateMixin {
  late Animation<double> _progressAnimation;
  late AnimationController _progressController;

  Pokemon get pokemon => widget.pokemon;

  AnimationController get slideController =>
      PokemonInfoStateProvider.of(context).slideController;

  @override
  void initState() {
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _progressAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        curve: Curves.easeInOut,
        parent: _progressController,
      ),
    );

    _progressController.forward();

    super.initState();
  }

  @override
  void dispose() {
    _progressController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: slideController,
      builder: (context, child) {
        final scrollable = slideController.value.floor() == 1;

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          physics: scrollable
              ? const BouncingScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          child: child,
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildStats(pokemon.stats),
          const SizedBox(height: 27),
        ],
      ),
    );
  }

  Widget buildStats(List<Stat>? stats) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: List.generate(
        stats?.length ?? 0,
        (index) => Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 12,
          ),
          child: StatWidget(
            animation: _progressAnimation,
            label: stats![index].statName!,
            value: stats[index].baseStat!,
          ),
        ),
      ),
    );
  }
}
