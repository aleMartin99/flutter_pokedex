// ignore_for_file: avoid_dynamic_calls, inference_failure_on_uninitialized_variable, type_annotate_public_apis, prefer_typing_uninitialized_variables, lines_longer_than_80_chars

import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/core/router/router_exports.dart';
import 'package:flutter_pokedex/core/services/services_exports.dart';
import 'package:flutter_pokedex/core/shared_components/shared_components_exports.dart';

import 'package:flutter_pokedex/domain/entities/pokemon.dart';
import 'package:flutter_pokedex/presentation/captured_screen/filter_bloc/filter_bloc.dart';
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
    filterBlocContextToDispose = context.read<FilterBloc>();
    scheduleMicrotask(() {
      context.read<PokemonBloc>().add(OnLoadCapturedPokemonsEvent());
      context.read<PokemonBloc>().add(OnLoadCapturedPokemonsEvent());
    });
  }

  late final filterBlocContextToDispose;

  @override
  void dispose() {
    super.dispose();
    filterBlocContextToDispose.add(OnResetFiltersEvent());
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

  ///List of
  List<String> filters = ['Alphabetically', 'By type', 'None'];

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
                  SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.4,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        enabledBorder: const UnderlineInputBorder(),
                        contentPadding: EdgeInsets.zero,
                        hintText: 'Fylter by',
                        hintStyle: const TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      onChanged: (String? value) async {
                        if (value == filters[0]) {
                          context.read<FilterBloc>().add(
                                OnToggleAlphabeticallyFilterEvent(
                                  isFilteringByAlphabetically:
                                      !filterState.isFilteringByAlphabetically,
                                ),
                              );
                        } else if (value == filters[1]) {
                          context.read<FilterBloc>().add(
                                OnToggleByTypeFilterEvent(
                                  isFilteringByType:
                                      !filterState.isFilteringByType,
                                ),
                              );
                        } else {
                          context.read<FilterBloc>().add(OnResetFiltersEvent());
                        }
                      },
                      items:
                          filters.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          alignment: Alignment.centerLeft,
                          value: value,
                          child: Text(
                            value,
                            textAlign: TextAlign.left,
                          ),
                        );
                      }).toList(),
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
                              crossAxisCount:
                                  (Platform.isMacOS || Platform.isWindows)
                                      ? 5
                                      : 2,
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
                                  : (filterState.isFilteringByType)
                                      ? List.generate(
                                          orderByType(
                                            pokemonState.capturedPokemonsList,
                                          ).length,
                                          (index) => PokemonCard(
                                            orderByType(
                                              pokemonState.capturedPokemonsList,
                                            )[index],
                                            onPress: () => _onPokemonPress(
                                              pokemonState
                                                  .capturedPokemonsList[index],
                                            ),
                                          ),
                                        )
                                      : List.generate(
                                          pokemonState
                                              .capturedPokemonsList.length,
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
