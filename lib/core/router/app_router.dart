// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter_pokedex/domain/entities/pokemon.dart';
import 'package:flutter_pokedex/presentation/captured_screen/captured_screen.dart';
import 'package:flutter_pokedex/presentation/home_screen/home_screen_exports.dart';
import 'package:flutter_pokedex/presentation/pokedex_screen/pokedex_screen_exports.dart';
import 'package:flutter_pokedex/presentation/pokemon_details_screen/pokemon_details_screen.dart';

/// key to compare home screen route
const String homeScreenRoute = '/home';

/// key to compare pokemonDetails screen route
const String pokemonDetailsScreenRoute = '/pokemonDetails';

/// key to compare pokedex screen route
const String pokedexScreenRoute = '/pokedex';

/// key to compare captured screen route
const String capturedScreenRoute = '/captured';

class AppRouter extends StatelessWidget {
  const AppRouter({super.key});

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case homeScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      case pokedexScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const PokedexScreen(),
        );
      case capturedScreenRoute:
        return MaterialPageRoute(
          builder: (_) => const CapturedScreen(),
        );

      case pokemonDetailsScreenRoute:
        if (args is PokemonDetailsArguments) {
          return MaterialPageRoute(
            builder: (_) => PokemonDetailsScreen(
              pokemon: args.pokemon,
            ),
          );
        } else {
          return _errorRoute();
        }

      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return const HomeScreen();
  }
}

Route<dynamic> _errorRoute() {
  return MaterialPageRoute(
    builder: (_) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('Error'),
        ),
      );
    },
  );
}

class PokemonDetailsArguments {
  const PokemonDetailsArguments(
    this.pokemon,
  );
  final Pokemon pokemon;
}
