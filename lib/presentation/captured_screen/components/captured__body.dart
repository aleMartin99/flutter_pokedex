import 'package:flutter/material.dart';
import 'package:flutter_pokedex/core/shared_components/shared_components_exports.dart';
import 'package:flutter_pokedex/presentation/captured_screen/captured_screen_exports.dart';

/// CapturedBody class
class CapturedBody extends StatefulWidget {
  ///
  const CapturedBody({super.key});

  @override
  State<CapturedBody> createState() => _CapturedBodyState();
}

class _CapturedBodyState extends State<CapturedBody> {
  @override
  Widget build(BuildContext context) {
    return PokeballScaffold(
      body: const Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: CapturedPokemonGrid(),
          ),
        ],
      ),
    );
  }
}
