import 'package:flutter/material.dart';

/// Animated fade class
class AnimatedFade extends AnimatedWidget {
  ///
  const AnimatedFade({
    required this.child,
    required this.animation,
    super.key,
  }) : super(listenable: animation);

  ///
  final Animation<double> animation;

  ///
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final opacity = animation.value;

    return IgnorePointer(
      ignoring: opacity < 1,
      child: Opacity(
        opacity: opacity,
        child: child,
      ),
    );
  }
}
