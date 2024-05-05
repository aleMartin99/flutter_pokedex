import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/core/router/router_exports.dart';
import 'package:flutter_pokedex/core/services/dynamic_color_service.dart';

import 'package:flutter_pokedex/core/theme/colors.dart';
import 'package:flutter_pokedex/presentation/home_screen/components/category_card.dart';
import 'package:flutter_pokedex/presentation/home_screen/components/header.dart';
import 'package:flutter_pokedex/presentation/pokedex_screen/pokemon_bloc/pokemon_bloc.dart';
import 'package:flutter_pokedex/core/theme/theme_provider.dart';
import 'package:provider/provider.dart';

/// HomeBody class
class HomeBody extends StatefulWidget {
  ///
  const HomeBody({
    super.key,
  });

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  void initState() {
    context.read<PokemonBloc>()
      ..add(OnLoadPokemonsEvent())
      ..add(OnLoadCapturedPokemonsEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: BlocListener<PokemonBloc, PokemonState>(
        listener: (context, state) {
          if (state.status == PokemonStatus.successLoadCaptured ||
              state.status == PokemonStatus.isCaptured ||
              state.status == PokemonStatus.isNotCaptured) {
            var predominantColor = getPredominantPoKeTypeColor(
              state.capturedPokemonsList,
            );

            if (Theme.of(context).primaryColor != predominantColor) {
              Provider.of<ThemeProvider>(context, listen: false)
                  .setPrimaryColor(predominantColor);
            }
          }
        },
        child: Column(
          children: [
            SizedBox(
              height: min(MediaQuery.sizeOf(context).height * 0.32, 382),
              child: HeaderSection(
                height: min(MediaQuery.sizeOf(context).height * 0.22, 282),
              ),
            ),
            GridView.count(
              childAspectRatio:
                  (Platform.isMacOS || Platform.isWindows) ? 3.2 : 2.7,
              crossAxisSpacing: 15,
              mainAxisSpacing: 12,
              shrinkWrap: true,
              primary: false,
              physics: const BouncingScrollPhysics(),
              crossAxisCount: (Platform.isMacOS || Platform.isWindows) ? 2 : 1,
              children: [
                CategoryCard(
                  title: 'Pokedex',
                  color: AppColors.primary.withOpacity(0.8),
                  onPressed: () async {
                    await Navigator.pushNamed(
                      context,
                      AppRoutes.pokedexScreenRoute,
                    );
                  },
                ),
                CategoryCard(
                  title: 'Captured',
                  color: AppColors.water,
                  onPressed: () async {
                    await Navigator.pushNamed(
                      context,
                      AppRoutes.capturedScreenRoute,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
