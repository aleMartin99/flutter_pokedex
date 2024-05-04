import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/core/router/router_exports.dart';
import 'package:flutter_pokedex/core/shared_components/loading.dart';
import 'package:flutter_pokedex/domain/entities/pokemon.dart';
import 'package:flutter_pokedex/presentation/pokedex_screen/components/pokemon_card.dart';
import 'package:flutter_pokedex/presentation/pokedex_screen/pokemon_bloc/pokemon_bloc.dart';
import 'package:flutter_pokedex/presentation/pokedex_screen/search_bloc/search_bloc.dart';

/// CapturedPokemonGrid class
class CapturedPokemonGrid extends StatefulWidget {
  ///
  const CapturedPokemonGrid({super.key});

  @override
  State<CapturedPokemonGrid> createState() => _CapturedPokemonGridState();
}

class _CapturedPokemonGridState extends State<CapturedPokemonGrid> {
  @override
  void initState() {
    super.initState();

    scheduleMicrotask(() {
      context.read<PokemonBloc>().add(OnLoadCapturedPokemonsEvent());
      context.read<PokemonBloc>().add(OnLoadCapturedPokemonsEvent());
    });
  }

  Future<void> _onPokemonPress(Pokemon pokemon) async {
    await Navigator.pushNamed(
      context,
      AppRoutes.pokemonDetailsScreenRoute,
      arguments: PokemonDetailsArguments(
        pokemon,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.06,
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 7),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(CupertinoIcons.left_chevron),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Captured',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        _buildGrid(),
      ],
    );
  }

  Widget _buildGrid() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, searchState) {
        return BlocBuilder<PokemonBloc, PokemonState>(
          builder: (context, pokemonState) {
            return pokemonState.status == PokemonStatus.loadingToggleCaptured ||
                    pokemonState.status == PokemonStatus.loading
                ? Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.34,
                      ),
                      const Center(
                        child: SizedBox(
                          height: 80,
                          child: PokeBallLoadingIndicator(),
                        ),
                      ),
                    ],
                  )
                : pokemonState.capturedPokemonsList.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: GridView.count(
                          padding: const EdgeInsets.symmetric(
                            vertical: 25,
                          ),
                          physics: const BouncingScrollPhysics(),
                          childAspectRatio: 1.2,
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 12,
                          children: List.generate(
                            pokemonState.capturedPokemonsList.length,
                            (index) => PokemonCard(
                              pokemonState.capturedPokemonsList[index],
                              onPress: () => _onPokemonPress(
                                pokemonState.capturedPokemonsList[index],
                              ),
                            ),
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.34,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            child: Text(
                              'Your journey is just starting ;)',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      );
          },
        );
      },
    );
  }
}
