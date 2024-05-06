// ignore_for_file: public_member_api_docs

import 'package:flutter/material.dart';

class PokemonInfoStateProvider extends InheritedWidget {
  ///
  const PokemonInfoStateProvider({
    required this.slideController,
    required this.rotateController,
    required super.child,
    super.key,
  });
  final AnimationController slideController;
  final AnimationController rotateController;

  static PokemonInfoStateProvider of(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<PokemonInfoStateProvider>();

    return result!;
  }

  @override
  bool updateShouldNotify(covariant PokemonInfoStateProvider oldWidget) =>
      false;
}
