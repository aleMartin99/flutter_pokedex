// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

class PokemonInfoStateProvider extends InheritedWidget {
  final AnimationController slideController;
  final AnimationController rotateController;

  const PokemonInfoStateProvider({
    super.key,
    required this.slideController,
    required this.rotateController,
    required super.child,
  });

  static PokemonInfoStateProvider of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<PokemonInfoStateProvider>();

    return result!;
  }

  @override
  bool updateShouldNotify(covariant PokemonInfoStateProvider oldWidget) =>
      false;
}
