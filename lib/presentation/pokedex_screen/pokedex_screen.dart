import 'package:flutter/material.dart';
import 'package:flutter_pokedex/presentation/pokedex_screen/pokedex_screen_exports.dart';

/// Pokedex screen
class PokedexScreen extends StatelessWidget {
  ///
  const PokedexScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: PokedexBody(),
    );
  }
}
