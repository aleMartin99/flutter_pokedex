import 'package:flutter/material.dart';
import 'package:flutter_pokedex/core/constants/image_constants.dart';

///Category card class
class CategoryCard extends StatelessWidget {
  ///
  const CategoryCard({
    required this.title,
    required this.color,
    super.key,
    this.onPressed,
  });

  ///
  final String title;

  ///
  final Color color;

  ///
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: SizedBox(
        height: 100,
        child: LayoutBuilder(
          builder: (_, constraints) {
            final height = constraints.maxHeight;

            return Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: _CardShadow(color: color),
                ),
                FilledButton(
                  onPressed: onPressed,
                  style: FilledButton.styleFrom(
                    padding: EdgeInsets.zero,
                    backgroundColor: color,
                    disabledBackgroundColor: color,
                    disabledForegroundColor:
                        Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: ClipRRect(
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: _CircleDecorator(size: height),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: _PokeballDecorator(size: height),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Text(
                            title,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onPrimary,
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _CardShadow extends StatelessWidget {
  const _CardShadow({
    required this.color,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      height: 11,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: color,
            offset: const Offset(0, 6),
            blurRadius: 23,
          ),
        ],
      ),
    );
  }
}

class _CircleDecorator extends StatelessWidget {
  const _CircleDecorator({required this.size});
  final double size;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(-size * 0.5, -size * 0.6),
      child: CircleAvatar(
        radius: size / 2,
        backgroundColor: Colors.white.withOpacity(0.14),
      ),
    );
  }
}

class _PokeballDecorator extends StatelessWidget {
  const _PokeballDecorator({required this.size});
  final double size;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 1.4,
      child: Image.asset(
        ImageConstants.pokeball,
        width: size,
        height: size,
        color: Colors.white.withOpacity(0.14),
        fit: BoxFit.contain,
      ),
    );
  }
}
