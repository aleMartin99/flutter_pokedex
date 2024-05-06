// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pokedex/core/router/router_exports.dart';
import 'package:flutter_pokedex/core/theme/theme_exports.dart';
import 'package:flutter_pokedex/main.dart';
import 'package:flutter_pokedex/presentation/captured_screen/filter_bloc/filter_bloc.dart';
import 'package:flutter_pokedex/presentation/pokedex_screen/pokemon_bloc/pokemon_bloc.dart';
import 'package:flutter_pokedex/presentation/pokedex_screen/search_bloc/search_bloc.dart';
import 'package:provider/provider.dart';

/// Base class for the application

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<PokemonBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<SearchBloc>(),
        ),
        BlocProvider(
          create: (context) => sl<FilterBloc>(),
        ),
      ],
      child: MaterialApp(
        theme: themeProvider.getTheme(),
        debugShowCheckedModeBanner: false,
        home: const AppRouter(),
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: AppRoutes.homeScreenRoute,
      ),
    );
  }
}
