import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pokedex/core/constants/constants_exports.dart';
import 'package:flutter_pokedex/domain/entities/pokemon.dart';

///Pokemon image class
class PokemonImage extends StatelessWidget {
  ///
  const PokemonImage({
    required this.pokemon,
    required this.size,
    super.key,
    this.padding = EdgeInsets.zero,
    this.useHero = true,
    this.placeholder,
    this.tintColor,
  });
  static const Size _cacheMaxSize = Size(700, 700);

  ///
  final Pokemon pokemon;

  ///
  final EdgeInsets padding;

  ///
  final bool useHero;

  ///
  final Size size;

  ///
  final ImageProvider? placeholder;

  ///
  final Color? tintColor;

  @override
  Widget build(BuildContext context) {
    return HeroMode(
      enabled: useHero,
      child: Hero(
        tag: pokemon.image!,
        child: AnimatedPadding(
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutQuint,
          padding: padding,
          child: CachedNetworkImage(
            imageUrl: pokemon.image ?? '',
            useOldImageOnUrlChange: true,
            maxWidthDiskCache: _cacheMaxSize.width.toInt(),
            maxHeightDiskCache: _cacheMaxSize.height.toInt(),
            fadeInDuration: const Duration(milliseconds: 120),
            fadeOutDuration: const Duration(milliseconds: 120),
            imageBuilder: (_, image) => Image(
              image: image,
              width: size.width,
              height: size.height,
              alignment: Alignment.bottomCenter,
              color: tintColor,
              fit: BoxFit.contain,
            ),
            placeholder: (_, __) => Image(
              image: placeholder ?? const AssetImage(ImageConstants.charmander),
              width: size.width,
              height: size.height,
              alignment: Alignment.bottomCenter,
              color: Colors.black12,
              fit: BoxFit.contain,
            ),
            errorWidget: (_, __, ___) => Stack(
              alignment: Alignment.center,
              children: [
                Image(
                  image: placeholder ??
                      const AssetImage(ImageConstants.charmander),
                  width: size.width,
                  height: size.height,
                  color: Colors.black12,
                ),
                Icon(
                  Icons.warning_amber_rounded,
                  size: size.width * 0.3,
                  color: Colors.black26,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
