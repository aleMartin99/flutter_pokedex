import 'package:flutter/material.dart';
import 'package:flutter_pokedex/core/theme/colors.dart';
import 'package:flutter_pokedex/data/models/pokemon_model/stat.dart';
import 'package:flutter_pokedex/domain/entities/pokemon.dart';
import 'package:flutter_pokedex/presentation/pokemon_details_screen/components/progress.dart';
// import 'package:flutter_pokedex/data/models/pokemon_model/stat.dart' as stats;
import 'package:flutter_pokedex/presentation/pokemon_details_screen/state_provider.dart';

class StatWidget extends StatelessWidget {
  final Animation animation;
  final String label;
  final double? progress;
  final num value;

  const StatWidget({
    super.key,
    required this.animation,
    required this.label,
    required this.value,
    this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
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
                    .withOpacity(0.6)),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text('$value'),
        ),
        Expanded(
          flex: 5,
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, widget) {
              final currentProgress = progress ?? value / 100;

              return ProgressBar(
                //TODO poner colores en dependencia de primary color
                progress: animation.value * currentProgress as double,
                color: currentProgress < 0.5 ? AppColors.red : AppColors.teal,
                enableAnimation: animation.value == 1,
              );
            },
          ),
        ),
      ],
    );
  }
}

class PokemonBaseStats extends StatefulWidget {
  final Pokemon pokemon;

  const PokemonBaseStats(this.pokemon);

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

    _progressAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      curve: Curves.easeInOut,
      parent: _progressController,
    ));

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
        mainAxisSize: MainAxisSize.max,
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
                padding: EdgeInsets.symmetric(
                  vertical: 12,
                ),
                child: StatWidget(
                  animation: _progressAnimation,
                  label: stats![index].statName!,
                  value: stats[index].baseStat!,
                ),
              ))
      // const SizedBox(height: 14),

      ,
    );
  }
}
