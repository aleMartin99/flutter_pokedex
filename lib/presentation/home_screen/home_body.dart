import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_pokedex/core/theme/colors.dart';
import 'package:flutter_pokedex/presentation/home_screen/components/category_card.dart';
import 'package:flutter_pokedex/presentation/home_screen/components/header.dart';

class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: min(MediaQuery.sizeOf(context).height * 0.32, 382),
            child: HeaderSection(
              height: min(MediaQuery.sizeOf(context).height * 0.22, 282),
            ),
          ),
          CategoryCard(
            title: 'Pokedex',
            color: AppColors.red,
            onPressed: () {},
          ),
          CategoryCard(
            title: 'Caught',
            color: AppColors.blue,
            onPressed: () {},
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