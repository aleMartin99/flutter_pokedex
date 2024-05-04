import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/core/router/router_exports.dart';
import 'package:flutter_pokedex/core/services/order_alphabetically_service.dart';
import 'package:flutter_pokedex/core/shared_components/loading.dart';
import 'package:flutter_pokedex/domain/entities/pokemon.dart';
import 'package:flutter_pokedex/presentation/captured_screen/filter_bloc/filter_bloc.dart';
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
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, filterState) {
        return Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.06,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(CupertinoIcons.left_chevron),
                  ),
                  IconButton(
                    onPressed: () => context.read<FilterBloc>().add(
                          OnToggleAlphabeticallyFilterEvent(
                            isFilteringByAlphabetically:
                                !filterState.isFilteringByAlphabetically,
                          ),
                        ),
                    icon: Icon(
                      Icons.filter_alt,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
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
      },
    );
  }

  Widget _buildGrid() {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, searchState) {
        return BlocBuilder<FilterBloc, FilterState>(
          builder: (context, filterState) {
            return BlocBuilder<PokemonBloc, PokemonState>(
              builder: (context, pokemonState) {
                return pokemonState.status ==
                            PokemonStatus.loadingToggleCaptured ||
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
                              children: (filterState
                                      .isFilteringByAlphabetically)
                                  ? List.generate(
                                      orderAlphabetically(
                                        pokemonState.capturedPokemonsList,
                                      ).length,
                                      (index) => PokemonCard(
                                        orderAlphabetically(
                                          pokemonState.capturedPokemonsList,
                                        )[index],
                                        onPress: () => _onPokemonPress(
                                          pokemonState
                                              .capturedPokemonsList[index],
                                        ),
                                      ),
                                    )
                                  : List.generate(
                                      pokemonState.capturedPokemonsList.length,
                                      (index) => PokemonCard(
                                        pokemonState
                                            .capturedPokemonsList[index],
                                        onPress: () => _onPokemonPress(
                                          pokemonState
                                              .capturedPokemonsList[index],
                                        ),
                                      ),
                                    ),
                            ),
                          )
                        : Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.34,
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
      },
    );
  }
}
