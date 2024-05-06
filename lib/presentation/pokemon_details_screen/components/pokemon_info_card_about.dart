// ignore_for_file: public_member_api_docs

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokedex/domain/entities/pokemon.dart';
import 'package:flutter_pokedex/presentation/pokemon_details_screen/state_provider.dart';

class Label extends StatelessWidget {
  ///
  const Label(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
        height: 0.8,
      ),
    );
  }
}

class ContentSection extends StatelessWidget {
  const ContentSection({
    required this.label,
    super.key,
    this.children,
  });
  final String label;
  final List<Widget>? children;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(height: 0.8, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 22),
        if (children != null) ...children!,
      ],
    );
  }
}

///PokemonPreview class
class PokemonPreview extends StatelessWidget {
  ///
  const PokemonPreview(this.pokemon, {super.key});

  ///
  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
    final slideController =
        PokemonInfoStateProvider.of(context).slideController;
    final screenSize = MediaQuery.sizeOf(context);
    final pokemonPreviewSize = screenSize.height * 0.25;

    return AnimatedBuilder(
      animation: slideController,
      builder: (context, child) {
        final scrollable = slideController.value.floor() == 1;

        return SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 27),
          physics: scrollable
              ? const BouncingScrollPhysics()
              : const NeverScrollableScrollPhysics(),
          child: child,
        );
      },
      child: Column(
        children: <Widget>[
          const SizedBox(height: 28),
          CachedNetworkImage(
            imageUrl: pokemon.livePreview!,
            useOldImageOnUrlChange: true,
            fadeInDuration: const Duration(milliseconds: 120),
            fadeOutDuration: const Duration(milliseconds: 120),
            imageBuilder: (_, image) => Image(
              image: image,
              filterQuality: FilterQuality.none,
              width: pokemonPreviewSize,
              height: pokemonPreviewSize,
              alignment: Alignment.bottomCenter,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }
}
