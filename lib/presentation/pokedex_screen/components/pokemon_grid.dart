import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/core/constants/api_helper.dart';
import 'package:flutter_pokedex/core/router/router_exports.dart';
import 'package:flutter_pokedex/core/shared_components/shared_components_exports.dart';
import 'package:flutter_pokedex/domain/entities/pokemon.dart';
import 'package:flutter_pokedex/presentation/pokedex_screen/pokedex_screen_exports.dart';
import 'package:flutter_pokedex/presentation/pokedex_screen/pokemon_bloc/pokemon_bloc.dart';
import 'package:flutter_pokedex/presentation/pokedex_screen/search_bloc/search_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

/// PokemonGrid class
class PokemonGrid extends StatefulWidget {
  ///
  const PokemonGrid({super.key});

  @override
  State<PokemonGrid> createState() => _PokemonGridState();
}

class _PokemonGridState extends State<PokemonGrid> {
  int _previousListLength = 0;

  late final PagingController<int, Pokemon> _pagingController =
      PagingController<int, Pokemon>(
    getNextPageKey: (state) {
      if (state.lastPageIsEmpty) {
        return null;
      }
      // Calculate next page key based on current items count
      final currentItemsCount = state.items?.length ?? 0;
      return currentItemsCount;
    },
    fetchPage: (pageKey) async {
      final bloc = context.read<PokemonBloc>();
      final limit = ApiHelper.defaultLimit;
      final offset = pageKey;

      // Use OnLoadPokemonsEvent for first page, OnLoadMorePokemonsEvent for others
      if (pageKey == 0) {
        _previousListLength = 0; // Reset for first page
        bloc.add(OnLoadPokemonsEvent(offset: offset, limit: limit));
        // Wait for initial load
        await bloc.stream.firstWhere(
          (state) => state.status != PokemonStatus.loading,
        );
      } else {
        bloc.add(
          OnLoadMorePokemonsEvent(offset: offset, limit: limit),
        );
        // Wait for loading more to complete
        await bloc.stream.firstWhere(
          (state) =>
              state.status != PokemonStatus.loadingMore &&
              !state.isLoadingMore,
        );
      }

      final blocState = bloc.state;
      if (blocState.status == PokemonStatus.failure) {
        throw Exception(blocState.failure ?? 'Error loading pokemons');
      } else {
        // Get only the new items (items that weren't in the previous list)
        final currentLength = blocState.pokemonsList.length;
        final newItems = blocState.pokemonsList
            .skip(_previousListLength)
            .take(currentLength - _previousListLength)
            .toList();
        _previousListLength = currentLength;

        // If we got fewer items than requested or hasReachedMax, mark as last page
        if (blocState.hasReachedMax || newItems.length < limit) {
          // The controller will detect this as empty next page
        }

        return newItems;
      }
    },
  );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
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
            // If searching, show filtered results without pagination
            if (searchState.isSearching) {
              final filteredPokemons = pokemonState.pokemonsList
                  .where(
                    (pokemon) => pokemon.name!
                        .toLowerCase()
                        .contains(searchState.searchWord),
                  )
                  .toList();

              if (filteredPokemons.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: Text(
                    'No results found',
                    textAlign: TextAlign.center,
                  ),
                );
              }

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GridView.count(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    physics: const BouncingScrollPhysics(),
                    childAspectRatio: 1.2,
                    crossAxisCount:
                        (Platform.isMacOS || Platform.isWindows) ? 5 : 2,
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 12,
                    children: filteredPokemons
                        .map(
                          (pokemon) => PokemonCard(
                            pokemon,
                            onPress: () => _onPokemonPress(pokemon),
                          ),
                        )
                        .toList(),
                  ),
                ),
              );
            }

            // Initial loading state
            if (pokemonState.status == PokemonStatus.loading &&
                pokemonState.pokemonsList.isEmpty) {
              return Column(
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
              );
            }

            // Error state
            if (pokemonState.status == PokemonStatus.failure &&
                pokemonState.pokemonsList.isEmpty) {
              return _buildError();
            }

            // Paginated grid view
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: PagingListener<int, Pokemon>(
                  controller: _pagingController,
                  builder: (context, state, fetchNextPage) =>
                      PagedGridView<int, Pokemon>(
                    state: state,
                    fetchNextPage: fetchNextPage,
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    physics: const BouncingScrollPhysics(),
                    builderDelegate: PagedChildBuilderDelegate<Pokemon>(
                      itemBuilder: (context, pokemon, index) => PokemonCard(
                        pokemon,
                        onPress: () => _onPokemonPress(pokemon),
                      ),
                      firstPageErrorIndicatorBuilder: (context) =>
                          _buildError(),
                      newPageErrorIndicatorBuilder: (context) => const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: Text('Error loading more pokemons'),
                        ),
                      ),
                      firstPageProgressIndicatorBuilder: (context) => Column(
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
                      ),
                      newPageProgressIndicatorBuilder: (context) =>
                          const Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: PokeBallLoadingIndicator(),
                        ),
                      ),
                      noItemsFoundIndicatorBuilder: (context) => _buildError(),
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          (Platform.isMacOS || Platform.isWindows) ? 5 : 2,
                      childAspectRatio: 1.2,
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 12,
                    ),
                  ),
                ),
              ),
            );
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
