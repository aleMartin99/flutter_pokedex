import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/core/router/router_exports.dart';
import 'package:flutter_pokedex/core/shared_components/app_bar.dart';
import 'package:flutter_pokedex/core/shared_components/loading.dart';
import 'package:flutter_pokedex/core/shared_components/pokemon_refresh_control.dart';
import 'package:flutter_pokedex/domain/entities/pokemon.dart';
import 'package:flutter_pokedex/presentation/pokedex_screen/components/pokemon_card.dart';
import 'package:flutter_pokedex/presentation/pokedex_screen/pokemon_bloc/pokemon_bloc.dart';

class PokemonGrid extends StatefulWidget {
  const PokemonGrid();

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
      // pokemonBloc.add(const PokemonLoadStarted());
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

  Future _onRefresh() async {
    // pokemonBloc.add(const PokemonLoadStarted());

    // return pokemonBloc.stream
    //     .firstWhere((e) => e.status != PokemonStateStatus.loading);
  }

  Future<void> _onPokemonPress(Pokemon pokemon) async {
    // pokemonBloc.add(PokemonSelectChanged(pokemonId: pokemon.number));
    await Navigator.pushNamed(
      context,
      AppRoutes.pokemonDetailsScreenRoute,
      arguments: PokemonDetailsArguments(
        pokemon,
      ),
    );
    // context.router.push(PokemonInfoRoute(id: pokemon.number));
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      key: _scrollKey,
      headerSliverBuilder: (_, __) => [
        AppMovingTitleSliverAppBar(
          leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(CupertinoIcons.left_chevron),
            ),
          ),
        ),
      ],
      body: _buildGrid(),
    );
  }

  Widget _buildGrid() {
    return BlocBuilder<PokemonBloc, PokemonState>(
      builder: (context, pokemonState) {
        return CustomScrollView(
          slivers: [
            PokemonRefreshControl(onRefresh: _onRefresh),
            SliverPadding(
              padding: const EdgeInsets.all(28),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                delegate: SliverChildBuilderDelegate(
                  (_, index) {
                    return PokemonCard(
                      pokemonState.pokemonsList[index],
                      onPress: () =>
                          _onPokemonPress(pokemonState.pokemonsList[index]),
                    );
                  },
                  childCount: pokemonState.pokemonsList.length,
                ),
              ),
            ),
            //           SliverToBoxAdapter(
            //               child:
            //                   // PokemonCanLoadMoreSelector((canLoadMore) {
            //                   //   if (!canLoadMore) {
            //                   //     return const SizedBox.shrink();
            //                   //   }
            // // (pokemonState.status == PokemonStatus.loading) {                    return const SizedBox.shrink()}
            //                   Container(
            //             padding: const EdgeInsets.only(bottom: 28),
            //             child: const PokeBallLoadingIndicator(),
            //           )
            //               // }),
            //               ),
          ],
        );
      },
    );
  }

  Widget _buildError() {
    return CustomScrollView(
      slivers: [
        PokemonRefreshControl(onRefresh: _onRefresh),
        SliverFillRemaining(
          child: Container(
            padding: const EdgeInsets.only(bottom: 28),
            alignment: Alignment.center,
            child: const Icon(
              Icons.warning_amber_rounded,
              size: 60,
              color: Colors.black26,
            ),
          ),
        ),
      ],
    );
  }
}
