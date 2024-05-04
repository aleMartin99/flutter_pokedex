import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/core/router/router_exports.dart';
import 'package:flutter_pokedex/core/theme/colors.dart';
import 'package:flutter_pokedex/presentation/home_screen/components/category_card.dart';
import 'package:flutter_pokedex/presentation/home_screen/components/header.dart';
import 'package:flutter_pokedex/presentation/pokedex_screen/pokemon_bloc/pokemon_bloc.dart';

/// HomeBody class
class HomeBody extends StatefulWidget {
  ///
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  void initState() {
    context.read<PokemonBloc>().add(OnLoadPokemonsEvent());
    context.read<PokemonBloc>().add(OnLoadCapturedPokemonsEvent());
    super.initState();
  }

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
            onPressed: () async {
              await Navigator.pushNamed(
                context,
                AppRoutes.pokedexScreenRoute,
              );
            },
          ),
          CategoryCard(
            title: 'Captured',
            color: AppColors.blue,
            onPressed: () async {
              await Navigator.pushNamed(
                context,
                AppRoutes.capturedScreenRoute,
              );
            },
          ),
        ],
      ),
    );
  }
}
