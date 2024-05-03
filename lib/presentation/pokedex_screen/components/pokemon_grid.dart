import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/core/router/router_exports.dart';
import 'package:flutter_pokedex/core/shared_components/loading.dart';
import 'package:flutter_pokedex/domain/entities/pokemon.dart';
import 'package:flutter_pokedex/presentation/pokedex_screen/components/pokemon_card.dart';
import 'package:flutter_pokedex/presentation/pokedex_screen/components/search_modal.dart';
import 'package:flutter_pokedex/presentation/pokedex_screen/pokemon_bloc/pokemon_bloc.dart';

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

  void _showSearchModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => const SearchBottomModal(),
    );
  }

// onPress: () => onPress(_showSearchModal),

  @override
  Widget build(BuildContext context) {
    //todo put fixxed search bar and title
    return Column(
      key: _scrollKey,
      children: [
        //TODO add back button
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.06,
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 7),
            child: IconButton(
              onPressed: _showSearchModal,
              icon: const Icon(CupertinoIcons.search),
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
        _buildGrid(),
      ],
    );
  }

  Widget _buildGrid() {
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, pokemonState) {
        return pokemonState.status == PokemonStatus.loading
            ? Column(
                children: [
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.34,
                  ),
                  const Center(
                    child:
                        SizedBox(height: 80, child: PokeBallLoadingIndicator()),
                  ),
                ],
              )
            : pokemonState.status == PokemonStatus.success
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
  }

  Widget _buildError() {
    return Center(
      child: Container(
        padding: const EdgeInsets.only(bottom: 28),
        alignment: Alignment.center,
        child: const Icon(
          Icons.warning_amber_rounded,
          size: 60,
          color: Colors.black26,
        ),
      ),
    );
  }
}
