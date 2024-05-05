import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/core/router/router_exports.dart';
import 'package:flutter_pokedex/core/shared_components/loading.dart';
import 'package:flutter_pokedex/domain/entities/pokemon.dart';
import 'package:flutter_pokedex/presentation/pokedex_screen/components/pokemon_card.dart';
import 'package:flutter_pokedex/presentation/pokedex_screen/components/search_field.dart';
import 'package:flutter_pokedex/presentation/pokedex_screen/pokemon_bloc/pokemon_bloc.dart';
import 'package:flutter_pokedex/presentation/pokedex_screen/search_bloc/search_bloc.dart';

/// PokemonGrid class
class PokemonGrid extends StatefulWidget {
  ///
  const PokemonGrid({super.key});

  @override
  State<PokemonGrid> createState() => _PokemonGridState();
}

class _PokemonGridState extends State<PokemonGrid> {
  static const double _endReachedThreshold = 200;

  final GlobalKey<NestedScrollViewState> _scrollKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    scheduleMicrotask(() {
      context.read<PokemonBloc>().add(OnLoadPokemonsEvent());
      _scrollKey.currentState?.innerController.addListener(_onScroll);
    });
  }

  @override
  void dispose() {
    _scrollKey.currentState?.innerController.dispose();
    _scrollKey.currentState?.dispose();

    super.dispose();
  }

  void _onScroll() {
    final innerController = _scrollKey.currentState?.innerController;

    if (innerController == null || !innerController.hasClients) return;

    final thresholdReached =
        innerController.position.extentAfter < _endReachedThreshold;

//TODO something to load more
    if (thresholdReached) {
      // Load more!
      // pokemonBloc.add(const PokemonLoadMoreStarted());
    }
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
      key: _scrollKey,
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
              'Pokedex',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: (Platform.isMacOS || Platform.isWindows)
                  ? MediaQuery.sizeOf(context).width * 0.4
                  : MediaQuery.sizeOf(context).width * 1,
              child: const SearchField(),
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
            return pokemonState.status == PokemonStatus.loading
                ? Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.sizeOf(context).height * 0.28,
                      ),
                      const Center(
                        child: SizedBox(
                          height: 80,
                          child: PokeBallLoadingIndicator(),
                        ),
                      ),
                    ],
                  )
                : pokemonState.pokemonsList.isNotEmpty
                    ? searchState.isSearching
                        ? pokemonState.pokemonsList
                                .where(
                                  (pokemon) => pokemon.name!
                                      .toLowerCase()
                                      .contains(searchState.searchWord),
                                )
                                .isEmpty
                            ? const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 50),
                                child: Text(
                                  'No results found',
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: GridView.count(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 25,
                                  ),
                                  physics: const BouncingScrollPhysics(),
                                  childAspectRatio: 1.2,
                                  shrinkWrap: true,
                                  crossAxisCount:
                                      (Platform.isMacOS || Platform.isWindows)
                                          ? 5
                                          : 2,
                                  crossAxisSpacing: 15,
                                  mainAxisSpacing: 12,
                                  children: pokemonState.pokemonsList
                                      .where(
                                        (pokemon) => pokemon.name!
                                            .toLowerCase()
                                            .contains(searchState.searchWord),
                                      )
                                      .map(
                                        (pokemon) => PokemonCard(
                                          pokemon,
                                          onPress: () => _onPokemonPress(
                                            pokemon,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              )
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: GridView.count(
                              padding: const EdgeInsets.symmetric(
                                vertical: 25,
                              ),
                              physics: const BouncingScrollPhysics(),
                              childAspectRatio: 1.2,
                              shrinkWrap: true,
                              crossAxisCount:
                                  (Platform.isMacOS || Platform.isWindows)
                                      ? 5
                                      : 2,
                              crossAxisSpacing: 15,
                              mainAxisSpacing: 12,
                              children: List.generate(
                                pokemonState.pokemonsList.length,
                                (index) => PokemonCard(
                                  pokemonState.pokemonsList[index],
                                  onPress: () => _onPokemonPress(
                                    pokemonState.pokemonsList[index],
                                  ),
                                ),
                              ),
                            ),
                          )
                    : _buildError();
          },
        );
      },
    );
  }

  Widget _buildError() {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.28,
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 28),
          alignment: Alignment.center,
          child: const Icon(
            Icons.warning_amber_rounded,
            size: 60,
            color: Colors.black26,
          ),
        ),
      ],
    );
  }
}
