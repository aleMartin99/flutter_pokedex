import 'package:flutter/material.dart';
import 'package:flutter_pokedex/presentation/home_screen/home_screen_exports.dart';

/// Home screen
class HomeScreen extends StatelessWidget {
  ///
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeBody(),
    );
  }
}
