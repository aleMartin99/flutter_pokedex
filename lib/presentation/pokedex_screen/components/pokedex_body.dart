import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pokedex/core/shared_components/custom_scaffold.dart';
import 'package:flutter_pokedex/presentation/pokedex_screen/components/pokemon_grid.dart';

/// PokedexBody class
class PokedexBody extends StatefulWidget {
  ///
  const PokedexBody({super.key});

  @override
  State<PokedexBody> createState() => _PokedexBodyState();
}

class _PokedexBodyState extends State<PokedexBody> {
  @override
  Widget build(BuildContext context) {
    return PokeballScaffold(
      body: const Stack(
        children: [
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: PokemonGrid(),
          ),
        ],
      ),
    );
  }

  // List<Map<String, dynamic>> loadedPokemonDetails = [];
  // ScrollController _scrollController = ScrollController();
  // int lastVisibleItemIndex = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   _scrollController.addListener(_onScroll);
  //   _loadInitialData(); // Function to load initial data
  // }

  // @override
  // void dispose() {
  //   _scrollController.removeListener(_onScroll);
  //   _scrollController.dispose();
  //   super.dispose();
  // }

  // void _onScroll() {
  //   if (_scrollController.position.atEdge) {
  //     if (_scrollController.position.pixels ==
  //         _scrollController.position.maxScrollExtent) {
  //       _loadMore();
  //     }
  //   }
  // }

  // @override
  // Widget build(BuildContext context) {
  //   return ListView.builder(
  //     controller: _scrollController,
  //     itemCount: loadedPokemonDetails.length,
  //     itemBuilder: (context, index) {
  //       return VisibilityDetector(
  //         key: Key(index.toString()), // Unique key for VisibilityDetector
  //         onVisibilityChanged: (VisibilityInfo info) {
  //           if (info.visibleFraction == 1) {
  //             lastVisibleItemIndex = index;
  //             print("Last visible item index: $lastVisibleItemIndex");
  //           }
  //         },
  //         child: ListTile(
  //           title: Text(loadedPokemonDetails[index]['name'] as String),
  //           subtitle: Text('ID: ${loadedPokemonDetails[index]['id']}'),
  //         ),
  //       );
  //     },
  //   );
  // }

  // void _loadMore() async {
  //   await fetchPokemonDetailsSubset(
  //     allPokemon.sublist(
  //       nextIndex,
  //       min(nextIndex + chunkSize, 151),
  //     ),
  //   ).then((newDetails) {
  //     setState(() {
  //       loadedPokemonDetails.addAll(newDetails);
  //       nextIndex += chunkSize;
  //       isLoading = false;
  //     });
  //   });
  //   // Method to load more data
  // }

  // bool isLoading = false;
  // int nextIndex = 0;
  // final int chunkSize = 20;

  // List<dynamic> allPokemon = [];
  // void _loadInitialData() async {
  //   await fetchPokemonList().then((pokemonList) {
  //     allPokemon = pokemonList;
  //     _loadMore(); // Initially load the first chunk
  //   });
  //   // Method to load initial data
  // }
}
