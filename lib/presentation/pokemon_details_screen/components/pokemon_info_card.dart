import 'package:flutter/material.dart';
import 'package:flutter_pokedex/domain/entities/pokemon.dart';
import 'package:flutter_pokedex/presentation/pokemon_details_screen/components/auto_slideup_panel.dart';
import 'package:flutter_pokedex/presentation/pokemon_details_screen/components/main_tab_view.dart';
import 'package:flutter_pokedex/presentation/pokemon_details_screen/components/pokemon_details_body.dart';
import 'package:flutter_pokedex/presentation/pokemon_details_screen/components/pokemon_info_card_basestats.dart';
import 'package:flutter_pokedex/presentation/pokemon_details_screen/state_provider.dart';

///PokemonInfoCard
class PokemonInfoCard extends StatefulWidget {
  ///
  const PokemonInfoCard({required this.pokemon, super.key});

  ///
  static const double minCardHeightFraction = 0.54;

  ///
  final Pokemon pokemon;
  @override
  State<PokemonInfoCard> createState() => _PokemonInfoCardState();
}

class _PokemonInfoCardState extends State<PokemonInfoCard> {
  AnimationController get slideController =>
      PokemonInfoStateProvider.of(context).slideController;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    final safeArea = MediaQuery.paddingOf(context);
    final appBarHeight = AppBar().preferredSize.height;

    final cardMinHeight = screenHeight * PokemonInfoCard.minCardHeightFraction;
    final cardMaxHeight = (screenHeight * 0.8) - appBarHeight - safeArea.top;

    return AutoSlideUpPanel(
      minHeight: cardMinHeight,
      maxHeight: cardMaxHeight,
      onPanelSlide: (position) => slideController.value = position,
      child: MainTabView(
        paddingAnimation: slideController,
        tabs: [
          MainTabData(
            label: 'Base Stats',
            child: PokemonBaseStats(widget.pokemon),
          ),
          MainTabData(
            label: 'Live Preview',
            child: PokemonPreview(widget.pokemon),
          ),
        ],
      ),
    );
  }
}
