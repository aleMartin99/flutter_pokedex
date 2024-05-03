import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_pokedex/core/constants/image_constants.dart';

/// Pokeball custom scaffold
class PokeballScaffold extends Scaffold {
  ///
  PokeballScaffold({
    super.key,
    super.appBar,
    super.floatingActionButton,
    super.floatingActionButtonLocation,
    super.floatingActionButtonAnimator,
    super.persistentFooterButtons,
    super.drawer,
    super.onDrawerChanged,
    super.endDrawer,
    super.onEndDrawerChanged,
    super.bottomNavigationBar,
    super.bottomSheet,
    super.backgroundColor,
    super.resizeToAvoidBottomInset,
    super.primary,
    super.drawerDragStartBehavior,
    super.extendBody,
    super.extendBodyBehindAppBar,
    super.drawerScrimColor,
    super.drawerEdgeDragWidth,
    super.drawerEnableOpenDragGesture,
    super.endDrawerEnableOpenDragGesture,
    super.restorationId,
    super.persistentFooterAlignment,
    Widget? body,
  }) : super(
          body: Stack(
            fit: StackFit.expand,
            children: [
              const PositionedPokeball(),
              if (body != null) body,
            ],
          ),
        );
}

///PositionedPokeball class
class PositionedPokeball extends StatelessWidget {
  ///
  const PositionedPokeball({
    super.key,
    this.widthFraction = 0.664,
    this.maxSize = 250,
  });

  ///
  final double widthFraction;

  ///
  final double maxSize;

  @override
  Widget build(BuildContext context) {
    final safeAreaTop = MediaQuery.paddingOf(context).top;
    final pokeballSize =
        min(MediaQuery.sizeOf(context).width * widthFraction, maxSize);
    const iconButtonPadding = 20;
    final iconSize = IconTheme.of(context).size ?? 0;

    final pokeballTopMargin =
        -(pokeballSize / 2 - safeAreaTop - kToolbarHeight / 2);
    final pokeballRightMargin =
        -(pokeballSize / 2 - iconButtonPadding - iconSize / 2);

    return Positioned(
      top: pokeballTopMargin,
      right: pokeballRightMargin,
      child: Image(
        image: const AssetImage(ImageConstants.pokeball),
        width: pokeballSize,
        height: pokeballSize,
        color: Theme.of(context).primaryColor.withOpacity(0.2),
      ),
    );
  }
}
