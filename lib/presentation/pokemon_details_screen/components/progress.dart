import 'package:flutter/material.dart';

/// ProgressBar class to show the stats.
class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    this.color,
    this.backgroundColor,
    this.enableAnimation = true,
    required this.progress,
  });

  final Color? backgroundColor;
  final Color? color;
  final double progress;
  final bool enableAnimation;

  @override
  Widget build(BuildContext context) {
    final child = Container(
      decoration: ShapeDecoration(
        shape: const StadiumBorder(),
        color: color ?? Theme.of(context).colorScheme.primary,
      ),
    );

    return Container(
      clipBehavior: Clip.hardEdge,
      height: 3,
      alignment: Alignment.centerLeft,
      decoration: ShapeDecoration(
        shape: const StadiumBorder(),
        color: Colors.grey,
      ),
      child: enableAnimation
          ? AnimatedAlign(
              duration: const Duration(milliseconds: 260),
              alignment: Alignment.centerRight,
              widthFactor: progress,
              child: child,
            )
          : FractionallySizedBox(
              widthFactor: progress,
              child: child,
            ),
    );
  }
}
